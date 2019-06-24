class User < ApplicationRecord
  has_many :entries, dependent: :destroy
  has_many :comments
  has_many :likings

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users

  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_users

  validates :username, uniqueness: true
  # has_secure_password
end
