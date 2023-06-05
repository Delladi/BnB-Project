require 'sinatra/base'
require 'sinatra/reloader'
require 'active_record'
#require 'database_connection'

# DatabaseConection.establish_database_connection

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end

  get '/signup' do
    return erb(:signup)
  end

  get '/login' do
    return erb(:login)
  end

  get '/bookings' do
    return erb(:bookings)
  end
end