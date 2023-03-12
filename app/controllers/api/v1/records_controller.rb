class Api::V1::RecordsController < ApplicationController
    skip_before_action :is_authorized, only: [:index]
    def index
        records = Record.all
        render json: records
    end

    def create
        area = Area.find_by_id(params[:area][:id])
        if area.user.id == @user.id && area.position != 0
            subarea = area.subareas.first
            subarea.records.create(detail_1_data: params[:detail_1_data], detail_2_data: params[:detail_2_data], detail_3_data: params[:detail_3_data] )
            render json: {data: subarea.records}
        else
            subarea.records.create(detail_1_data: params[:detail_1_data], detail_2_data: params[:detail_2_data], detail_3_data: params[:detail_3_data] )
            render json: {data: subarea.records}
        end
    end

    def user_params
        params.require(:record).permit(area: [:id], subarea: [:id], detail_1_data: [:detail_1_data], detail_2_data: [:detail_2_data], detail_3_data: [:detail_3_data])
    end
end
