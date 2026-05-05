class Api::V1::AuthController < ApplicationController
    skip_before_action :verify_authenticity_token

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

    private

    def user_params
        params.permit(:firstName, :lastName, :email, :country, :password)
        .to_h.transform_keys { |key| key.underscore }.symbolize_keys
    end
end
