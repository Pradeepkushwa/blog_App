class CommentsController < ApplicationController
     skip_before_action :verify_authenticity_token
     before_action :authenticate_request
     before_action :set_post, only: [:create]
	def create
		debugger

		@comment = @post.comments.new(comment_params)
		@comment.user = @current_user
		if @comment.save
			render json: @comment, each_serializer: CommentSerializer, status: :created
		else
			render json: {error: @comment.errors.full_messages}, 
			     status: :unprocessable_entity
	    end
	end

	def set_post
		@post = Post.find(params[:post_id])
		rescue ActiveRecord::RecordNotFound
	        render json: {error: "post not found"}, status: :not_found
	end

	def comment_params
		params.permit(:comment)
	end
end
