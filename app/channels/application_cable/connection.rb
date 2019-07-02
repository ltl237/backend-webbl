module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
    def connect
      # byebug
      self.current_user = find_verified_user
    end

    private

    # def find_verified_user
    #   if verified_user = User.find_by(id: cookies.encrypted[:user_id])
    #     verified_user
    #   else
    #     reject_unauthorized_connection
    #   end
    # end
    def find_verified_user
      # byebug
       if current_user = User.find_by(id: JWT.decode(cookies["X-Authorization"],"", false)[0]['user_id'])
           current_user
       else
          reject_unauthorized_connection
       end
       # byebug
    end


  end
end

# rbmodule ApplicationCable class Connection < ActionCable::Connection::Base
#  identified_by :current_user
#
#  private
#  def find_verified_user
#    if verified_user = User.find_by(id: cookies.encrypted[:user_id])
#      verified_user
#      else
#        reject_unauthorized_connection
#      end
#    end
#    end
#  end
