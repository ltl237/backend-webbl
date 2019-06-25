class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :user, :entry
  belongs_to :user
  belongs_to :entry
  # has_one :user
  # has_one :entry
end
