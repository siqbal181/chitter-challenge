require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/peep_repository'
require_relative 'lib/user_repository'
require 'sinatra/flash'

DatabaseConnection.connect('chitter_database')

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
  end

  register Sinatra::Flash

  get '/' do
    # need to show peeps on the homepage
    repo = PeepRepository.new
    @peeps = repo.all

    return erb(:homepage)
  end

  get '/register' do
    return erb(:register)
  end

  post '/register' do # once user has registered
    if params[:email_address].nil? || !params[:email_address].include?('@') || params[:username].nil? || params[:password].nil?
      status 400
      return ''
    end

    repo = UserRepository.new
    user = User.new
    user.email_address = params['email_address']
    user.username = params['username']
    user.password = params['password']
    repo.create(user)
    
    redirect '/'
  end

  get '/login' do
    return erb(:login)
  end

  post '/login' do
    email_address = params[:email_address]
    username = params[:username]
    password = params[:password]

    repo = UserRepository.new
    # check if the username, email and decrypt password match the account
    user = repo.find_by_email(email_address)
    if user.username == username && user.email_address == email_address && user.password == password
      return erb(:login)
    else
      halt 404, "Invalid input"
    end
  end
end