class Api::V1::EntriesController < ApplicationController
  # skip_before_action :authorized
  def index
    @entries = Entry.all
    render json: @entries
  end

  def create
    @entry = Entry.new(entry_params)

    respond_to do |format|
      if @entry.save
        entry_data = {
          action: 'new_entry',
          entry: @entry
        }
        ActionCable.server.broadcast('entries',entry_data)
        format.html { redirect_to @entry, notice: 'Ticket was successfully created.' }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end
  #THIS WORKS ALSO WITH SOME A/C. DOESNT REAAALLY WORK
  # def create
  #   byebug
  #   @entry = Entry.new(entry_params)
  #   puts params[:id]
  #   if @entry.save
  #     serialized_data = ActiveModelSerializers::Adapter::Json.new(
  #       EntrySerializer.new(@entry)
  #     ).serializable_hash
  #     ActionCable.server.broadcast 'entries_channel', serialized_data
  #     head :ok
  #     # render json: @entry
  #   end
  #   # byebug
  # end
  #This WORKS ALSO, OLD

  #BEFORE A/C, WORKING
  # def create
  #   # byebug
  #   @entry = Entry.new(entry_params)
  #   @entry.save
  #   byebug
  #   if @entry.save
  #     render json: @entry, status: :accepted
  #   else
  #     render json: { errors: @entry.errors.full_messages }, status: :unprocessible_entity
  #   end
  # end
  #^^BEFORE A/C, WORKING
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
