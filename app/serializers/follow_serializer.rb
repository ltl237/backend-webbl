class FollowSerializer < ActiveModel::Serializer
  attributes :id, :follower#, :followee
  belongs_to :user
  belongs_to :entry

  # has_one :user
  # has_one :entry
end
