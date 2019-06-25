class Api::V1::LikingsController < ApplicationController
  # skip_before_action :authorized
  def index
    @likings = Liking.all
    render json: @likings
  end

  def new
    @liking = Liking.new
  end

  def create
    @liking = Liking.new(liking_params)
    @liking.save
    render json: @liking
  end

  def destroy
    Liking.destroy(Liking.find(params[:id]).id)
  end

  private

  def liking_params
    params.require(:liking).permit(:id,:user_id, :post_id)
  end
end
