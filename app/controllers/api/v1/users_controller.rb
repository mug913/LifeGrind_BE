class Api::V1::UsersController < ApplicationController
    skip_before_action :is_authorized, only: [:create, :login, :show, :index]

    def create_key
        exp = Time.now.to_i + 1 * 6000
        @token = JWT.encode({user_id: @user.id, exp: exp}, Rails.application.secrets.secret_key_base[0])
    end

    #user data delivered on fetch
    def user_profile
        create_key()
        render json: {user: UserSerializer.new(@user, fields: {areas: [:name]}).serializable_hash, token: @token, status: 202}
        #render json: UserSerializer.new(@user).serializable_hash
    end

    # for testing purposes
    def show
        user = User.find_by_id(params[:id])
        render json: UserSerializer.new(user, fields: {areas: [:name]}).serializable_hash
    end

    def index
        users = User.all
        render json: users
    end

    def create
        user = User.create(user_params)
        if user.save
            #create default DayArea
            user.areas.create(name: "DayLog", position: 0, streak: 0, level: 0)
            #create first unassigned Area
            user.areas.create(name: "", position: 1, streak: 0, level: 0)
            login()
        else
            render json: {error: user.errors.full_messages, status: 422}
        end
    end

    def login
        @user = User.find_by(email: params[:user][:email])
        if @user && @user.authenticate(params[:user][:password])
       #     exp = Time.now.to_i + 1 * 6000
       #     token = JWT.encode({user_id: user.id, exp: exp}, Rails.application.secrets.secret_key_base[0])
            create_key()
            render json: {user: UserSerializer.new(@user, fields: {areas: [:name]}).serializable_hash, token: @token, status: 202}
        else 
            render json: {error: "Email or Password Invalid", status: 401}
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :password, :email)
    end

end