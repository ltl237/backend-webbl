class User < ApplicationRecord
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :comments#, through: :entries
  has_many :likings
  has_many :followees, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, foreign_key: :follower_id, class_name: 'Follow'
  # has_and_belongs_to_many :conversations, dependent: :destroy
  validates :username, uniqueness: true
  ###CAN I USE THIS
  has_many :user_conversations
  has_many :conversations, through: :user_conversations


  # has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  # has_many :followees, through: :followed_users


  # has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  # has_many :followers, through: :following_users

  # has_many :sent, foreign_key: :sender_id, class_name: 'Message'
  # has_many :sent_messages, through: :sent

  # has_many :received, foreign_key: :receiver_id, class_name: 'Message'
  # has_many :received_messages, through: :received


  has_secure_password
end
