# frozen_string_literal: true

class String
  def self.random(length = 10)
    chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
    random_string = String.new ''
    length.times { |_i| random_string << chars[rand(chars.length)] }
    random_string
  end
end
