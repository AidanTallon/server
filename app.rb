require 'sinatra'
require 'dotenv/load'
require 'mongo'

require 'pry'

client = Mongo::Client.new(['127.0.0.1:27017'], :database => 'test')
db = client.database

get '/' do
  'test'
end

post '/test' do
  db[:test].insert_one(name: params['stuff'])
end

get '/test' do
  db[:text].find(name: params['stuff']).first
end
