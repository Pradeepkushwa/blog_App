ActiveStorage::Current.url_options = Rails.application.routes.default_url_options

class PostsController < ApplicationController
	skip_before_action :verify_authenticity_token
    before_action :authenticate_request
     
	def create
         debugger
		@post = @current_user.posts.new(post_params)
		if @post.save
			render json: @post, each_serializer: PostSerializer, status: :created
		else
			render json: {error: @post.errors.full_messages},
			status: :unprocessable_entity
		end
	end
    private
	def post_params
		params.permit(:title,:content,:publication_date,:image)
	end
end
