class ModelsController < ApplicationController
	before_action :set_model, only: [:show, :update, :destroy]

	# GET All
	def index
		models = Model.all.map{|m| m.dto_json }

		render json: models, status: :ok
	end

	# GET com ID
	def show
		render json: @model.dto_json, status: :ok
	end

	# POST
	def create
		@model = Model.new(
			description: params["description"],
			manufacturer: params["manufacturer"]
		)

		@model.save
		
		render json: @model.dto_json, status: :ok
	rescue
		render status: :bad_request
	end

	# PUT e PATCH
	def update
		@model.update(
			description: params["description"],
			manufacturer: params["manufacturer"]
		)

		render json: @model.dto_json, status: :ok
	rescue
		render status: :bad_request
	end

	# DELETE
	def destroy
		if @model.planes.blank?
			@model.destroy

			render json: @model.dto_json, status: :ok
			return
		end

		render json: { message: "This Model has Planes associated." }, status: :bad_request
	end

	private
	def set_model
		model_id = params[:id]

		if model_id.present?
			@model = Model.find(model_id)
		else
			render status: :bad_request
		end
	end
end