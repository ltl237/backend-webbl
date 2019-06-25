class EntrySerializer < ActiveModel::Serializer
  belongs_to :user
  has_many :comments
  has_many :likings
  attributes :id, :title, :category, :content, :user_id, :created_at, :comments
  # has_one :user
end
