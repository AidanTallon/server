require 'digest'

class User
  attr_reader :id, :name, :type, :client_id, :account_id

  def self.db=(value)
    @@db = value
  end

  @@sha256 = Digest::SHA256.new

  def self.get(user_id)
    data = @@db.find(:users, { "user_id": user_id }).first
    if data.nil?
      return nil
    else
      return User.new data
    end
  end

  def self.authenticate(params)
    username = params['username']
    password = params['password']
    pw_hash = @@sha256.base64digest password
    user_data = @@db.find(:users, { username: username, hash: pw_hash}).first
    if user_data.nil?
      return nil
    else
      return self.get(user_data['user_id'])
    end
  end

  def initialize(data)
    @id = data['user_id']
    @name = data['username']
    @type = data['user_type'].to_sym
    @client_id = data['client_id']
    @account_id = data['account_id']
  end
end
