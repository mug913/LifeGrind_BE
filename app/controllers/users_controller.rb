class UsersController < ApplicationController

    def index
        @users = User.all
        render json: @users
    end

    def create
        @user = User.create(user_params)
        
        render json: @user, status: :created
    end

    def login
        @user = User.find_by(email: params[:user][:email])
        if @user && @user.authenticate(params[:user][:email])
        else render json: {error: "Invalid login"}, status: :unauthorized
    end

    private

    def user_params
        params.require(:user).permit(:username, :password, :email)
    end

end