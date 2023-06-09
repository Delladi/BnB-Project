require 'sinatra/base'
require 'sinatra/reloader'
require 'active_record'
require_relative 'lib/booking'
require_relative 'lib/database_connection'
require_relative 'lib/user'
require_relative 'lib/listing'

DatabaseConnection.establish_database_connection

class Application < Sinatra::Base
  UPLOADS_DIRECTORY = File.join(__dir__, 'public/img')
  enable :sessions

  configure do
    set :public_folder, UPLOADS_DIRECTORY
  end

  configure :development do
    register Sinatra::Reloader
  end

  set :public_folder, File.join(__dir__, 'public')

  get '/style.css' do
    content_type 'text/css'
    send_file File.join(settings.public_folder, 'style.css')
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    # Code for handling signup
  end

  get '/login' do
    return erb(:login)
  end

  get '/logout' do
    session.clear  
    redirect '/' 
  end

  get '/account_page' do
    return erb(:account_page)
  end

  post '/login' do
    user = User.sign_in(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      redirect '/account_page'
    else
      redirect '/login_failure'
    end
  end

  get '/listings/:id/bookings' do
    if session[:user_id] == nil
      #session - a gem that stores user information
      redirect '/login'
    else
      @listing = Listing.find_by(id: params[:id])
      return erb(:bookings)
    end
  end
  
  post '/listings/:id/bookings' do
    @listing = Listing.find_by(id: params[:id])
    binding.irb
    booking = Booking.create_booking(

      params[:date_from],
      params[:date_to],
      params[:id],
      session[:user_id]
    )
    # Send a response indicating success
    'Listing created successfully.'
  end

  get '/listings' do
    @all_listings = Listing.all
    erb :listings
  end

  get '/create_listings' do
    erb :create_listings
  end

  post '/create_listings' do
    # Access the uploaded image file using params[:image]
    if params[:image].nil? || params[:image][:tempfile].nil?
      # Handle error if no file is uploaded
      return 'No file uploaded.'
    end
  
    # Handle the rest of the form data and image processing/saving
    listing = Listing.create_listing(
      params[:listing_name],
      params[:available_from],
      params[:available_to],
      params[:price_per_night],
      params[:description],
      params[:location],
      params[:description],
      session[:user_id]
    )

  
    # Save the uploaded image file to the designated directory
    listing_id = listing.id
    user_id = params[:user_id]
    filename = "#{listing_id}.#{params[:image][:filename].split('.').last}"
    tempfile = params[:image][:tempfile]
    File.open(File.join(UPLOADS_DIRECTORY, filename), 'wb') do |file|
      file.write(tempfile.read)
    end
    redirect '/account_page/success'
  end

  # get '/1' do
  #   return erb(:stylish_cottage_getaway)
  # end

  get '/account_page/success' do
    erb :success
  end

  get '/listings/:id' do
    @listing = Listing.find_by(id: params[:id])
    erb :listing_template
  end

  run! if app_file == $0
end
