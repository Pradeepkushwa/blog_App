class UsersController < ApplicationController
	skip_before_action :verify_authenticity_token
   before_action :set_user, only: [:show, :destroy]

   def index
       @users = User.all
       render json: @users, each_serializer: UserSerializer, status: "200"
   end	

   def show
      render json: @user, each_serializer: UserSerializer, status: "200"
   end

   def create
    @user = User.new(user_params)
      if @user.save
         render json: @user, each_serializer: UserSerializer, status: :created
      else 
    	   render json: {errors: @user.errors.full_messages},
    	   status: :unprocessable_entity
      end
   end
 
   def update
      unless @user.update(user_params)
         render json: {error: @user.errors.full_messages},
         status: :unprocessable_entity
      end
   end

   def destroy
      @user.destroy
      render json: {message: "User is deleted successfully"}, status: "200"
   end

   private

   def user_params
 	params.permit(:name,:email,:password)
   end

   def set_user
      @user = User.find(params[:id])
   end
end
