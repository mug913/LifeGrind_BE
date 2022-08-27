class Api::V1::RecordsController < ApplicationController
    skip_before_action :is_authorized, only: [:index]
    def index
        records = Record.all
        render json: records
    end

    def create
        area = Area.find_by_id(params[:area][:id])
        # Rails.logger.info `Pos=#{area.position}`
        if area.user.id == @user.id && area.position != 0
            # subarea = Subarea.find_by_id(params[:subarea][:id])
            subarea = area.subareas.first
            Rails.logger.info area.subareas.length
            subarea.records.create(detail_1_data: params[:detail_1_data], detail_2_data: params[:detail_2_data], detail_3_data: params[:detail_3_data] )
        else
            subarea.records.create(detail_1_data: params[:detail_1_data], detail_2_data: params[:detail_2_data], detail_3_data: params[:detail_3_data] )
        end
    end

    def user_params
        params.require(:record).permit(area: [:id], subarea: [:id], detail_1_data: [:detail_1_data], detail_2_data: [:detail_2_data], detail_3_data: [:detail_3_data])
    end
end
