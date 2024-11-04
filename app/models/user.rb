# app/models/user.rb
class User < ApplicationRecord
  has_secure_password

  # Ensure a user can have multiple posts
  has_many :posts, dependent: :destroy

  validates :name, :username, :email, presence: true
  validates :email, uniqueness: true
end
