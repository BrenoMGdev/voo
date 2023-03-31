class PilotsController < ApplicationController
	before_action :set_pilot, only: [:show, :update, :destroy]
	rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

	# GET All
	def index
		render status: :bad_request
	end

	# GET com ID
	def show
		render json: @pilot.to_json, status: :ok
	end

	# POST
	def create
		@pilot = Pilot.new(
			name: params[:nome],
			password: params[:senha],
			aircraft: params[:aeronave]
		)

		if @pilot.save
			render json: @pilot.to_json, status: :ok
		else
			render status: :bad_request
		end
	end

	# PUT e PATCH
	def update
		if @pilot.update(
			name: params[:nome],
			password: params[:senha],
			aircraft: params[:aeronave]
		)
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