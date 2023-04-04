class PilotsController < ApplicationController
	before_action :set_pilot, only: [:show, :update, :destroy]
	rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

	# GET All
	def index
		pilots = Pilot.all.map{|p| p.to_json }

		render json: pilots, status: :ok
	end

	# GET com ID
	def show
		render json: @pilot.to_json, status: :ok
	end

	# POST
	def create
		@pilot = Pilot.new(Pilot::prepare_params(params))

		if @pilot.save
			render json: @pilot.to_json, status: :ok
		else
			render status: :bad_request
		end
	end

	# PUT e PATCH
	def update
		if @pilot.update(Pilot::prepare_params(params))
			render json: @pilot.to_json, status: :ok
		else
			render status: :bad_request
		end
	end

	# DELETE
	def destroy
		@pilot.destroy

		render json: @pilot.to_json, status: :ok
	end

	private
	def set_pilot
		pilot_id = params[:id]

		if pilot_id.present?
			@pilot = Pilot.find(pilot_id)
		else
			render status: :bad_request
		end
	end

	def record_not_found
		render json: {}, status: :not_found
	end
end