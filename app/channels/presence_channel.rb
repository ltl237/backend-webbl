class PresenceChannel < ApplicationCable::Channel
   def subscribed
      stream_for "presence_channel"
   end
end
