class User < ApplicationRecord
  has_many :posts
  attr_accessor :remember_token
  before_create :assign_token
  has_secure_password

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(string)
    Digest::SHA1.hexdigest(string).to_s
  end

  def remember
    assign_token
    save
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  private

  def assign_token
    self.remember_token = User.new_token
    self.remember_digest = User.digest(remember_token)
  end
end
