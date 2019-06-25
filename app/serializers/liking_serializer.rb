class LikingSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :user
  belongs_to :entry
  # has_one :user
  # has_one :entry
end
