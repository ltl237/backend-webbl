class Api::V1::MessagesController < ApplicationController

  def index
    messages = Message.all
    # byebug
    render json: messages
  end

  def create
    message = Message.new(text: params[:text], conversation_id: params[:conversation_id], user_id: session_user.id)
    # message.text = params[:text]

    # byebug
    conversation = Conversation.find(message_params[:conversation_id])
    # byebug
    if message.save
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        MessageSerializer.new(message)
      ).serializable_hash
      # MessagesChannel.broadcast_to conversation, serialized_data
      ActionCable.server.broadcast(
          # Broadcast to general open channel
          'messages_channel',

          # Broadcast to user/sender private channel
          # "current_user_#{session_user.id}",
          serialized_data
      )

      # ActionCable.server.broadcast(
      #     # Broadcast to user/receiver private channel
      #     "current_user_#{params["receiver_id"]}",
      #     serialized_data
      # )
      head :ok
      else
        render json: message.errors.full_messages
    end
  end

  private

  def message_params
    params.require(:message).permit(:text, :conversation_id)
  end
end
