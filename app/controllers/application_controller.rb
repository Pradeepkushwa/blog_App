class ApplicationController < ActionController::Base

	private
	def authenticate_request
		header = request.headers["token"] 
		header = header.split(" ").last if header
		begin
		   @decoded = JsonWebToken.decode(header)
		   @current_user = User.find_by(id: @decoded[:user_id])
	    rescue ActiveRecord::RecordNotFound => e
	    	render json: {error: e.message}, status: :unauthorized
	    rescue JWT::DecodeError => e
	    	render json: {error: e.message}, status: :unauthorized
	    end
	end
end

