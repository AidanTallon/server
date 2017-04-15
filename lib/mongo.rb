require 'mongo'

class MongoClient
  def initialize(address, db)
    @@client = Mongo::Client.new([address], database: db)
    @@db = @@client.database
  end

  def insert_one(col, params)
    @@db[col].insert_one(params)
  end

  def find(col, params)
    @@db[col].find(params)
  end
end
