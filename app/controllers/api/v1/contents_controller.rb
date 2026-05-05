class Api::V1::ContentsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authorize_user #What is this?
    before_action :set_content, only: [:update]
    
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
    
    def update
        if @content.user_id != @current_user.id
            render json: { error: "Forbidden" }, status: :forbidden
        return
        end

        if @content.update(content_params)
            render json: { message: "Content updated", data: @content }
        else
            render json: { errors: @content.errors.full_messages }
        end
    end

    private

    def set_content
        @content = @current_user.contents.find_by(id: params[:id])

        unless @content
            render json: { error: "Not found or not authorized" }, status: :not_found
        end
    end

    def content_params
        params.permit(:title, :body)
    end
end
