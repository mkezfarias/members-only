class User < ApplicationRecord
  before_create :assign_token
  has_secure_password

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(string)
    Digest::SHA1.hexdigest(string).to_s
  end

  private

  def assign_token
    self.remember_digest = User.digest(User.new_token)
  end
end
