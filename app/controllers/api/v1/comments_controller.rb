class Api::V1::CommentsController < ApplicationController
  # skip_before_action :authorized

  def index
    @comments = Comment.all
    render json: @comments
  end

  def create
    @comment = Comment.new(comment_params)
    # byebug
    @comment.save
    # byebug
    render json: @comment
  end

  def destroy
    Comment.destroy(Comment.find(params[:id]).id)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :entry_id)
  end
end
