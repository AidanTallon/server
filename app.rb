require 'sinatra'
require 'dotenv/load'
require 'mongo'

require 'pry'

client = Mongo::Client.new(['127.0.0.1:27017'], :database => 'test')
db = client.database

db_test = db[:test]
db_transaction = db[:transaction]

def auth_user(password)
  password == ENV['PASSWORD']
end

get '/' do
  'test'
end

post '/test' do
  if auth_user params['user']
    input = params
    input.delete('user')
    db_test.insert_one(input).to_s
  end
end

get '/test' do
  db_test.find(params).first.to_s
end

post '/transaction' do
  if auth_user params['user']
    input = params
    input.delete('user')
    db_transaction.insert_one(params)
  end
end
