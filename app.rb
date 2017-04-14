require 'sinatra'
require 'dotenv/load'
require 'json'
require 'mongo'

require './lib/user.rb'
require './lib/mongo.rb'

require 'pry'

$mongo = MongoClient.new

class App < Sinatra::Base
  set sessions: true

  register do
    def auth(type)
      condition do
        redirect '/login' unless send("is_#{type}?")
      end
    end
  end

  helpers do
    def is_user?
      @user != nil
    end

    def is_admin?
      @user != nil && @user.type == :admin
    end
  end

  before do
    @user = User.get(session[:user_id])
  end

  get '/', auth: :user do
    "Hello, #{@user.name}."
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    user = User.authenticate(params)
    if user.nil?
      redirect '/login'
    else
      session[:user_id] = User.authenticate(params).id
      redirect '/'
    end
  end

  get '/logout' do
    session[:user_id] = nil
  end
end

App.run!
