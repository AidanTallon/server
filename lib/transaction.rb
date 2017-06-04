class Transaction
  attr_reader :data

  def self.all
    @@all ||= []
  end

  def self.ids
    @@ids ||= []
  end

  def self.db=(value)
    @@db = value
  end

  def self.monzo=(value)
    @@monzo = value
  end

  def self.account_id=(value)
    @@account_id = value
  end

  def self.update
    data = @@monzo.get_transactions
    return nil if data.code == 401
    data.each do |t|
      unless self.ids.include? data['id']
        Transaction.new t
      end
    end
    self.sync_to_db
  end

  def self.sync_to_db
    @@all.each do |t|
      if @@db.findOne(:transactions, {id: t.id}).first.nil?
        @@db.insert(:transactions, t.data)
      end
    end
  end

  def initialize(data)
    binding.pry
    @data = data
    @id = data['id']
    self.all << self
    self.ids << @id
  end
end
