require 'sinatra'
require 'dotenv/load'
require 'mail'

get '/' do
  'test'
end

get '/message/:body' do
  mail = Mail.deliver do
    from ENV['EMAIL']
    to ENV['EMAIL']
    subject 'test'
    body params[:body]
  end
end
