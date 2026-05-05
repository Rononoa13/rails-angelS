class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  # 
  SECRET_KEY = Rails.application.secret_key_base
  
  def encode_token(payload)
    JWT.encode(payload, SECRET_KEY)
  end

  def decode_token(token)
    JWT.decode(token, SECRET_KEY)[0].with_indifferent_access
  rescue
    nil
  end
  ##############################
  #### Authentication Layer ####
  ##############################

  def current_user
    auth_header = request.headers["Authorization"]
    return nil unless auth_header

    token = auth_header.split(" ").last
    decoded = decode_token(token)

    return nil unless decoded

    User.find_by(id: decoded[:user_id])
  end
  
  def authorize_user
    user = current_user

    if user.nil?
      render json: { error: "Unauthorized" }, status: :unauthorized
    else
      @current_user = user
    end
  end
  
end
