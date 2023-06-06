require 'sinatra/base'
require 'sinatra/reloader'
require 'active_record'
require_relative 'lib/database_connection'
require_relative 'lib/user'

DatabaseConnection.establish_database_connection

class Application < Sinatra::Base
  enable :sessions
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end

  get '/signup' do
    return erb(:signup)
  end

  post '/signup' do
    database = User.all_records
    match_found = false
  
    database.each do |record|
      if record.username == params[:username] || record.email == params[:email]
        match_found = true
        break
      end
    end
  
    if match_found
      redirect '/signup'
    else
      User.create_user(params[:name], params[:username], params[:email], params[:password])
      redirect '/success'
    end
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

  get '/bookings' do
    return erb(:bookings)
  end

  get '/listings' do
    return erb(:listings)
  end

  get '/1' do
    return erb(:stylish_cottage_getaway)
  end

  get '/success' do
    return erb(:success)
  end
end