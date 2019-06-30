class CommentsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    entry = Entry.find(params[:entry])
    stream_for conversation
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
