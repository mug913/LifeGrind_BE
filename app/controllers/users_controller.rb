class UsersController < ApplicationController
    skip_before_action :is_authorized, only: [:create, :login]

    def user_profile
        render json: @user
    end
    
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
        if @user && @user.authenticate(params[:user][:password])
            exp = Time.now.to_i + 1 * 600
            @token = JWT.encode({user_id: @user.id, exp: exp}, Rails.application.secrets.secret_key_base[0])
            render json: {user: @user, token: @token}
        else 
            render json: {error: "Invalid login"}, status: :unauthorized
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :password, :email)
    end

end