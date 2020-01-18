class User < ApplicationRecord
  has_many :posts
  attr_accessor :remember_token
  before_create :assign_token
  has_secure_password

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end

    BCrypt::Password.create(string, cost: cost)
  end

  def remember
    assign_token
    save
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def authenticated?(remember_token)
    return false unless remember_digest

    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  private

  def assign_token
    self.remember_token = User.new_token
    self.remember_digest = User.digest(remember_token)
  end
end
