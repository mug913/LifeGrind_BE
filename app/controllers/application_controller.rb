class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token
    before_action :is_authorized

    def is_authorized
        render json: {error: "Please Log In"} unless is_signed_in
    end

    def is_signed_in
        !!current_user
    end

    #get token from request and decode to verify user.
    def current_user
    #request string containing bearer and token
        auth_header = request.headers["Authorization"]
    #separate token from returned string
        if auth_header
            user_token = auth_header.split(" ")[1]
            begin
            @user_id = JWT.decode(user_token, Rails.application.secrets.secret_key_base[0])[0]["user_id"]
    #prevent and JWT Decode error to crash app and instead return nil        
            rescue JWT::DecodeError
                nil
            end
        end
        if(@user_id)
            @user = User.find(@user_id)
        else
            render json:  {error: "access denied"}
        end
    end

end
