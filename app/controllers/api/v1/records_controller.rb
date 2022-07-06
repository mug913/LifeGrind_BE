class Api::V1::RecordsController < ApplicationController
    skip_before_action :is_authorized, only: [:index]
    def index
        records = Record.all
        render json: records
    end

    def create
        subarea = Subarea.find_by_id(params[:subarea][:id])
            subarea.records.create(detail_1_data: params[:detail_1_data], detail_2_data: params[:detail_2_data], detail_3_data: params[:detail_3_data] )
    end

    def user_params
        params.require(:record).permit(area: [:id], subarea: [:id])
    end
end
