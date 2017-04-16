require 'httparty'

class MonzoClient
  include HTTParty
  base_uri 'https://api.monzo.com'
end
