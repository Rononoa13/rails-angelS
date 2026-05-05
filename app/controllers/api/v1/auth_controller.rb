class Api::V1::AuthController < ApplicationController
    skip_before_action :verify_authenticity_token
    ###########
    # Sign Up #
    ###########
    def signup
        user = User.new(user_params)
        if user.save
            render json: { 
                message: "User created successfully",
                user: user
            }, status: :created
        else
            render json: { 
                message: "User creation failed",
                errors: user.errors.full_messages
            }, status: :unprocessable_entity
        end
    end

    ###########
    # Sign In #
    ###########
    def signin
        user = User.find_by(email: params[:auth][:email])

        if user&.authenticate(params[:auth][:password])
            token = encode_token({ user_id: user.id })
            
            render json: {
                data: {
                    id: user.id,
                    type: "users",
                    attributes: {
                    token: token,
                    email: user.email,
                    name: "#{user.first_name} #{user.last_name}",
                    country: user.country
                    }
                }
            }, status: :ok
        else
            render json: { 
                message: "Invalid email or password"
            }, status: :unauthorized
        end
    end

    private

    def user_params
        params.permit(:firstName, :lastName, :email, :country, :password)
        .to_h.transform_keys { |key| key.underscore }.symbolize_keys
    end
end
