 class AuthenticationController < ApplicationController
    skip_before_action :verify_authenticity_token

	def login
		@user = User.find_by_email(params[:email])
		if @user&.authenticate(params[:password])
		   token = JsonWebToken.encode(user_id: @user.id)
		   render json: {token: token}, status: "200"
		else
			render json: {error: 'unauthorize'}, status: "401"
		end
	end
end
