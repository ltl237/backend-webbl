class ApplicationController < ActionController::API
  # before_action :authorized

  def encode_token(payload)
    # should store secret in env variable
    JWT.encode(payload, 'my_s3cr3t')
  end

  def auth_header
    # { Authorization: 'Bearer <token>' }
    request.headers['Authorization']
  end

  def decoded_token
    # byebug
    if auth_header
      # byebug
      # token = auth_header.split(' ')[1]
      token = auth_header.split(' ')[1]
      # header: { 'Authorizaton': 'Bearer <token>' }
      # byebug
      begin
        # byebug
        JWT.decode(token, 'my_s3cr3t', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def session_user
    if decoded_token
      # byebug
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!session_user
  end

  def authorized
    render json: { errors: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
