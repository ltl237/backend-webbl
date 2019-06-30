class Api::V1::CommentsController < ApplicationController
  # skip_before_action :authorized

  def index
    @comments = Comment.all
    render json: @comments
  end

  def create
    @comment = Comment.new(comment_params)
    @entry = Conversation.find(comment_params[:entry_id])
    if @comment.save
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        CommentsSerializer.new(@comment)
      ).serializable_hash
      CommentsChannel.broadcast_to @entry, serialized_data
      head :ok
    end

  end
  #BEFORE A/C, WORKING
  # def create
  #   @comment = Comment.new(comment_params)
  #   # byebug
  #   @comment.save
  #   # byebug
  #   render json: @comment
  # end
  #^^^BEFORE A/C, WORKING
  def destroy
    Comment.destroy(Comment.find(params[:id]).id)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :entry_id)
  end
end
