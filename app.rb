require 'sinatra'
require 'dotenv/load'
require 'mail'

get '/' do
  'test'
end

post '/message/:body' do
  mail = Mail.new do
    from ENV['EMAIL']
    to ENV['EMAIL']
    subject 'test'
    body params[:body]
end
