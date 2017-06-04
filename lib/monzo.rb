require 'httparty'

class MonzoClient
  include HTTParty
  base_uri 'https://api.monzo.com'

  def initialize(client_id, account_id)
    @client_id = client_id
    @account_id = account_id
  end

  def get_transactions
    res = self.class.get "/transactions?expand[]=merchant&account_id=#{@account_id}"
  end

  def auth

  end
end
