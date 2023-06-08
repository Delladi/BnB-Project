require 'sinatra/base'
require 'sinatra/reloader'
require 'active_record'
require_relative 'lib/database_connection'
require_relative 'lib/user'
require_relative 'lib/listing'

DatabaseConnection.establish_database_connection

class Application < Sinatra::Base
  UPLOADS_DIRECTORY = File.join(__dir__, 'img')
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

  # Rest of the routes...

  get '/listings' do
    @all_listings = Listing.all
    erb :listings
  end

  get '/create_listings' do
    erb :create_listings
  end

  post '/create_listings' do
    # Code for creating listings and saving images
  end

  # Rest of the routes...

  get '/success' do
    erb :success
  end

  get '/listings/:id' do
    @listing = Listing.find_by(id: params[:id])
    erb :listing_template
  end

  run! if app_file == $0
end
