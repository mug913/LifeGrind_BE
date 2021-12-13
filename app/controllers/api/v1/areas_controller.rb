class Api::V1::AreasController < ApplicationController
    skip_before_action :is_authorized, only: [:show, :index]

    def create
        @user.areas.create(name: params[:name], position: (@user.areas.length + 1), streak: 0, level: 0)
        render json: {areas: @user.areas, status: 422}
    end


    def user_params
        params.require(:area).permit(:name)
    end

end
