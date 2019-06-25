class Api::V1::FollowsController < ApplicationController
  # skip_before_action :authorized
  def index
    @follows = Follow.all
    render json: @follows
  end

  def new
    @follow = Follow.new
    render json: @follow
  end

  def create
    @follow = Follow.new(follow_params)
    @follow.save
    render json: @follow
  end

  def destroy
    Follow.destroy(Follow.find(params[:id]).id)
  end

  private

  def follow_params
    params.require(:follow).permit(:follower_id, :followee_id)
  end
end
