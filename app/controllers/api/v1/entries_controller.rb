class Api::V1::EntriesController < ApplicationController
  # skip_before_action :authorized
  def index
    @entries = Entry.all
    render json: @entries
  end

  def create
    # byebug
    @entry = Entry.new(entry_params)
    @entry.save
    byebug
    if @entry.save
      render json: @entry, status: :accepted
    else
      render json: { errors: @entry.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def edit

  end

  def update
    @entry = Entry.find(params[:id])
    @entry.update(entry_params)
    if @entry.save
      render json: @entry, status: :accepted
    else
      render json: { errors: @entry.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def show
    @entry = Entry.find(params[:id])
    render json: @entry
  end

  def destroy
    Entry.destroy(Entry.find(params[:id]).id)
  end

  private

  def entry_params
    params.require(:entry).permit(:title, :content, :category, :user_id)
  end
end
