class UserSerializer < ActiveModel::Serializer
  has_many :entries
  has_many :comments#, through: :entries
  # has_many :messages
  # has_many :likings, through: :entries

  # has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, foreign_key: :followee_id, class_name: 'Follow'
  # has_many :followees, through: :followed_users

  # has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, foreign_key: :follower_id, class_name: 'Follow'
  # has_many :followers, through: :following_users

  # has_many :sent, foreign_key: :sender_id, class_name: 'Message'
  # has_many :sent_messages, through: :sent

  # has_many :received, foreign_key: :receiver_id, class_name: 'Message'
  # has_many :received_messages, through: :received

  attributes :id, :first_name, :last_name, :username, :bio, :age, :conversations#,:password_digest
end
