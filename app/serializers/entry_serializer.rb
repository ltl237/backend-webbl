class EntrySerializer < ActiveModel::Serializer
  attributes :id, :title, :category, :content
  has_one :user
end
