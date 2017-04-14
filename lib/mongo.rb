require 'mongo'

class MongoClient
  @@client = Mongo::Client.new(['127.0.0.1:27017'], database: 'test')
  @@db = @@client.database

  @@test_db = @@db[:test]
  @@transactions_db = @@db[:transactions]
  @@users_db = @@db[:users]

  def insert_one(col, params)
    @@db[col].insert_one(params)
  end

  def find(col, params)
    @@db[col].find(params)
  end
end
