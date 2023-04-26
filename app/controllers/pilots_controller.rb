class PilotsController < ApplicationController
	before_action :set_pilot, only: [:show, :update, :destroy]

	# GET All
	def index
		pilots = Pilot.all.map{|p| p.dto_json }

		render json: pilots, status: :ok
	end

	# GET com ID
	def show
		render json: @pilot.dto_json, status: :ok
	end

	# POST
	def create
		abble_to_fligh = params["abble_to_fligh"].map do |m|
			Model.find(m.try(:[], "id"))
		end

		@pilot = Pilot.new(
			name: params["name"],
			password: params["password"],
			abble_to_fligh: abble_to_fligh
		)

		@pilot.save

		render json: @pilot.dto_json, status: :ok
	rescue
		render status: :bad_request
	end

	# PUT e PATCH
	def update
		abble_to_fligh = params["abble_to_fligh"].map do |m|
			Model.find(m.try(:[], "id"))
		end

		@pilot.update(
			name: params["name"],
			password: params["password"],
			abble_to_fligh: abble_to_fligh
    )
			
		render json: @pilot.dto_json, status: :ok
	rescue
		render status: :bad_request
	end

	# DELETE
	def destroy
		if @pilot.flight_schedule.blank?
			@pilot.destroy

			render json: @pilot.dto_json, status: :ok
			return
		end

		render status: :bad_request
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
end