class Api::V1::AreasController < ApplicationController
    skip_before_action :is_authorized, only: [:show, :index]

      # for testing purposes
    def show
        area = Area.find_by_id(params[:id])
        render json: AreaSerializer.new(area, fields: {subareas: [:name]}).serializable_hash
    end

    def create
        #limit of 6 on backend precautionary, should be prohibited by UI design on front end. 
        if @user.areas.length < 7
           next_pos = find_next_pos()
           @user.areas.create(name: "", position: (next_pos), streak: 0, level: 0)
        end
            render json: {areas: @user.areas, status: 422}
    end

    def edit
        area = Area.find_by(id: params[:id])
        area.update(name: params[:name])
           subarea = area.subareas.create(name: "default", position: (area.subareas.length))
        create()
    end

    def destroy
        #destroy requested area
        area = Area.find_by(id: params[:id])
        area.destroy!
        #if another vacant area exists, destroy it as well
        blanks = @user.areas.where("name = ''")
        blanks.filter_map {|blank|  blank.delete if blank.position != params[:pos].to_i}
        #reinitialize area field for new creation
        create()
    end

    def find_next_pos
        positions = (0..6).to_a
        #logger.debug "positions: #{positions}" 
        occupied_pos = @user.areas.map {|a| a.position}
        #logger.debug "occupied: #{occupied_pos}"
        open_pos = positions - occupied_pos
        #logger.debug "nextd: #{open_pos.first}"
        return open_pos.first
    end

    def user_params
        params.require(:area).permit(:name, :pos)
    end

end
