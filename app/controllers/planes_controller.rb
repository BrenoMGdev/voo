class PlanesController < ApplicationController
	before_action :set_plane, only: [:show, :update, :destroy]

	# GET All
	def index
		planes = Plane.all.map{|p| p.dto_json }

		render json: planes, status: :ok
	end

	# GET com ID
	def show
		render json: @plane.dto_json, status: :ok
	end

	# POST
	def create
		model = Model.find(params["model"].try(:[], "id")) if params["model"].present?

		@plane = Plane.new(
			registration: params["registration"],
			model: model,
			manufacturing_date: params["manufacturing_date"]
		)

		if not @plane.valid?
			raise
		end
		
		@plane.save
		
		render json: @plane.dto_json, status: :ok
	rescue
		render status: :bad_request
	end

	# PUT e PATCH
	def update
		model = Model.find(params["model"].try(:[], "id")) if params["model"].present?

		@plane.update(
			model: model,
			manufacturing_date: params["manufacturing_date"]
		)
			
		render json: @plane.dto_json, status: :ok
	rescue
		render status: :bad_request
	end

	# DELETE
	def destroy
		@plane.destroy

		render json: @plane.dto_json, status: :ok
	end

	private
	def set_plane
		plane_registration = params[:registration]

		if plane_registration.present?
			@plane = Plane.find(plane_registration)
		else
			render status: :bad_request
		end
	end
end