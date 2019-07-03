class MessagesChannel < ApplicationCable::Channel
  def subscribed
      # sleep 3
    # conversation = Conversation.find(params[:conversation])
    # stream_for conversation
    # stream_for "current_user_#{current_user.id}"
    stream_from "messages_channel"
  end

  # def unsubscribed
    # stop_all_streams
  # end
end
