class PlanesController < ApplicationController
	before_action :set_plane, only: [:show, :update, :destroy]
	rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

	# GET All
	def index
		planes = Plane.all.map{|p| p.to_json }

		render json: planes, status: :ok
	end

	# GET com ID
	def show
		render json: @plane.to_json, status: :ok
	end

	# POST
	def create
		print(params)
		@plane = Plane.new({
            id: params["id"],
            model: params["model"],
            date: params["date"],
			registration: params["registration"]
        })

		if @plane.save
			render json: @plane.to_json, status: :ok
		else
			render status: :bad_request
		end
	end

	# PUT e PATCH
	def update
		if @plane.update(Plane.new({
            model: params["model"],
            date: params["date"],
			registration: params["registration"]
        }))
			render json: @plane.to_json, status: :ok
		else
			render status: :bad_request
		end
	end

	# DELETE
	def destroy
		@plane.destroy

		render json: @plane.to_json, status: :ok
	end

	private
	def set_plane
		plane_id = params[:id]

		if plane_id.present?
			@pilot = Plane.find(plane_id)
		else
			render status: :bad_request
		end
	end

	def record_not_found
		render json: {}, status: :not_found
	end
end