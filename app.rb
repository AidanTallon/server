require 'sinatra'
require 'dotenv/load'
require 'mongo'

require 'digest'

require 'pry'

client = Mongo::Client.new(['127.0.0.1:27017'], :database => 'test')
db = client.database

def auth_user(password)
  sha256 = Digest::SHA256.new
  if sha256.digest(password) == ENV['HASH']
    return true
  else
    return false
  end
end

get '/' do
  'test'
end

post '/test' do
  if auth_user params['user']
    db[:test].insert_one(name: params['stuff']).to_s
  end
end

get '/test' do
  db[:test].find(name: params['stuff']).first.to_s
end
