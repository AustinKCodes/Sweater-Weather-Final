class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  has_secure_password
  before_create :create_api_key

  def create_api_key
    self.api_key = SecureRandom.hex(15)
  end
end

#method that is getting ran before the user is being created to give it the API key