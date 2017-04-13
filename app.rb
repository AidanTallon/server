require 'sinatra'
require 'dotenv/load'
require 'mongo'

require 'pry'

client = Mongo::Client.new(['127.0.0.1:27017'], :database => 'test')
db = client.database

get '/' do
  'test'
end

post '/test/:stuff' do
  db[:test].insert(name: params['stuff'])
end

get '/test/:id' do
  db[:text].find(name: params['stuff']).first
end
