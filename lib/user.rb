require 'digest'

class User
  attr_reader :id, :name, :type

  def self.db=(value)
    @@db = value
  end

  @@sha256 = Digest::SHA256.new

  def self.get(user_id)
    data = @@db.find(:users, { "user_id": user_id }).first
    if data.nil?
      return nil
    else
      return User.new data['user_id'], data['username'], data['user_type']
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

  def initialize(user_id, username, user_type)
    @id = user_id
    @name = username
    @type = user_type.to_sym
  end
end
