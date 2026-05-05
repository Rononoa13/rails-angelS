class Api::V1::ContentsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authorize_user #What is this?

    def create
        content = Content.new(content_params)
        content.user = @current_user

        if content.save
            render json: {
                data: {
                    id: content.id,
                    type: "contents",
                    attributes: {
                        title: content.title,
                        body: content.body,
                        createdAt: content.created_at,
                        updatedAt: content.updated_at
                    }
                }
            }, status: :created
        else
            render json: { 
                message: "Content creation failed",
                errors: content.errors.full_messages
            }, status: :unprocessable_entity
        end
    end
    
    def index
        contents = @current_user.contents
        render json: {
            data: contents.map do |content|
                {
                    id: content.id,
                    type: "content",
                    attributes: {
                        title: content.title,
                        body: content.body,
                        createdAt: content.created_at,
                        updatedAt: content.updated_at
                    }
                }
            end
        }, status: :ok
    end
    
    private

    def content_params
        params.permit(:title, :body)
    end
end
