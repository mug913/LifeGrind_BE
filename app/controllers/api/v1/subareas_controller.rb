class Api::V1::SubareasController < ApplicationController
    skip_before_action :is_authorized, only: [:show, :index]

    def show
        subarea = Subarea.find_by_id(params[:id])
        render json: SubareaSerializer.new(subarea, fields: {records: [:name]}).serializable_hash
    end

    def create
        #limit of 6 on backend precautionary, should be prohibited by UI design on front end. 
        area = Area.find_by_id(params[:area])
        if area.user.id == @user.id
            if area.position == 0 && area.subareas.length < 7
                area.subareas.create(name: params[:options][:name], position: (area.subareas.length), streak: 0, level: 0)
                render json: {data: area.subareas, status: 422}
            end
        end
    end

    def user_params
        params.require(:subarea).permit(:area, options: [:name])
    end

end
