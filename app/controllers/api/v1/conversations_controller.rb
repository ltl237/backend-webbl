class Api::V1::ConversationsController < ApplicationController
  def index
    conversations = Conversation.all
    # byebug
    render json: conversations
  end


  def create

      # 1. Create a new conversation in the db.
      puts ActionCable.server.connections.length
      # Conversation.all
      reverse_title = conversation_params[:title].split('-').reverse().join('-')
      # byebug

      # byebug
      if (Conversation.find_by(title: conversation_params[:title]) || Conversation.find_by(title: reverse_title))
        render json: (Conversation.find_by(title: conversation_params[:title]) || Conversation.find_by(title: reverse_title))
      else
        conversation = Conversation.new(conversation_params)
        if conversation.save

            # 2. Create each relationship between conversation and both users via join table user_conversation. Both conversation users are passed in params.
            ownership1 = UserConversation.new()
            ownership1.conversation_id = conversation.id
            ownership1.user_id = params["sender_id"]
            ownership1.save
            ownership2 = UserConversation.new()
            ownership2.conversation_id = conversation.id
            ownership2.user_id = params["receiver_id"]
            ownership2.save

            # 3. Get the serialized data for the conversation as defined in ConversationSerializer
            serialized_data = ActiveModelSerializers::Adapter::Json.new(
                ConversationSerializer.new(conversation)
            ).serializable_hash

             # 3. Broadcast new serialized conversation to both channel subscribers.
            ActionCable.server.broadcast(
                # Broadcast to general open channel
                'conversations_channel',

                # Broadcast to user/sender private channel
                # "current_user_#{session_user.id}",
                serialized_data
            )

            # ActionCable.server.broadcast(
            #     # Broadcast to user/receiver private channel
            #     # "current_user_#{params["receiver_id"]}",
            #     serialized_data
            # )

            head :ok
          else
            render json: conversation.errors.full_messages
        end
      end

  end

  private

  def conversation_params
      params.require(:conversation).permit(:title, :sender_id, :receiver_id)
  end

  ###BEFOREEEEE WORKING###
  # def create
  #   conversation = Conversation.new(conversation_params)
  #   # byebug
  #   if conversation.save
  #     serialized_data = ActiveModelSerializers::Adapter::Json.new(
  #       ConversationSerializer.new(conversation)
  #     ).serializable_hash
  #     ActionCable.server.broadcast 'conversations_channel', serialized_data
  #     head :ok
  #   end
  # end
  private

  def conversation_params
    params.require(:conversation).permit(:title)
  end
  ###BEFOREEEEE WORKING###
end
