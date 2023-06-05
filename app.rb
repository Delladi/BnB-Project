require 'sinatra/base'
require 'sinatra/reloader'
require 'activerecord'
require 'database_connection'

establish_database_connection

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end
end