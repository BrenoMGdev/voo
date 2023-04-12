class ModelsController < ApplicationController
	before_action :set_model, only: [:show, :update, :destroy]
	rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

	# GET All
	def index
		models = Model.all.map{|p| p.to_json }

		render json: models, status: :ok
	end

	# GET com ID
	def show
		render json: @model.to_json, status: :ok
	end

	# POST
	def create
		print(params)
		@model = Model.new({
            id: params["id"],
            model: params["model"],
            manufacturer: params["manufacturer"]
        })

		if @model.save
			render json: @model.to_json, status: :ok
		else
			render json: @model.save!.to_json, status: :bad_request
		end
	end

	# PUT e PATCH
	def update
		if @model.update(Model.new({
            model: params["model"],
            manufacturer: params["manufacturer"]
        }))
			render json: @model.to_json, status: :ok
		else
			render status: :bad_request
		end
	end

	# DELETE
	def destroy
		@model.destroy

		render json: @model.to_json, status: :ok
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

	def record_not_found
		render json: {}, status: :not_found
	end
end