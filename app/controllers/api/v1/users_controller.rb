class Api::V1::UsersController < ApplicationController
    skip_before_action :is_authorized, only: [:create, :login, :show, :index]

    #user data delivered on fetch
    def user_profile
        render json: UserSerializer.new(@user).serializable_hash
    end

    # for testing purposes
    def show
        user = User.find_by_id(params[:id])
        
        render json: UserSerializer.new(user, fields: {areas: [:name]}).serializable_hash

       # render json: user
    end

    def index
        users = User.all
        render json: users
    end

    def create
        user = User.create(user_params)
        if user.save
            for i in 0..6 do
                user.areas.create(name: "", position: i, streak: 0, level: 0)
            end
            login()
        else
            render json: {error: user.errors.full_messages, status: 422}
        end
    end

    def login
        user = User.find_by(email: params[:user][:email])
        if user && user.authenticate(params[:user][:password])
            exp = Time.now.to_i + 1 * 6
            token = JWT.encode({user_id: user.id, exp: exp}, Rails.application.secrets.secret_key_base[0])
            render json: {user: UserSerializer.new(user, fields: {areas: [:name]}).serializable_hash, token: token}
        else 
            render json: {error: "Email or Password Invalid", status: 401}
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :password, :email)
    end

end