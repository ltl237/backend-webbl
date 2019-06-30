require 'securerandom'
class EntriesChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stop_all_streams
    stream_from "entries_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def fetch_all_entries
    Entry.all.each do |entry|
      entry_data = {
        action: 'new_entry',
        entry: entry
      }
      ActionCable.server.broadcast('entries',entry_data)
    end
  end

  def new_entry(entry)
    # normally would create a entry in the database here

    entry = {
      subject: entry["entry"],
      id: SecureRandom.uuid
    }
    message_data = {
      action: 'new_entry',
      entry: entry,
    }
    ActionCable.server.broadcast('entries',entry_data)
  end
end
