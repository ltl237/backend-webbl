class ConversationSerializer < ActiveModel::Serializer

  attributes :id, :title

  has_many :messages
  has_many :users, serializer:ConversationUserSerializer

end

# class UserConversationSerializer < ActiveModel::Serializer
#   attributes :id
#   has_one :user
#   has_one :conversation
# end
