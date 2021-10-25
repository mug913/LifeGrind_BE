class Api::V1::UsersController < ApplicationController
    skip_before_action :is_authorized, only: [:create, :login, :show, :index]

    #user data delivered on fetch
    #def user_profile
    #    render json: user
    #end

    # for testing purposes
    def show
        user = User.find_by_id(params[:id])
        
        output = UserSerializer.new(user).serializable_hash.to_json
        render json: output

       # render json: user
    end

    def index
        users = User.all
        render json: users
    end

    def create
        user = User.create(user_params)
        for i in 1..7 do
            user.areas.create(name: "", position: i, streak: 0, level: 0)
        end
       ##render json: user, status: :created
       login()
    end

    def login
        user = User.find_by(email: params[:user][:email])
        if user && user.authenticate(params[:user][:password])
            exp = Time.now.to_i + 1 * 600
            token = JWT.encode({user_id: user.id, exp: exp}, Rails.application.secrets.secret_key_base[0])
            render json: {user: UserSerializer.new(user).serializable_hash, token: token}
        else 
            render json: {error: "Invalid login"}, status: :unauthorized
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :password, :email)
    end

end