class AirportsController < ApplicationController
	before_action :set_airport, only: [:show, :update, :destroy]

	# GET All
	def index
		airports = Airport.all.map{|a| a.dto_json }

		render json: airports, status: :ok
	end

	# GET com ID
	def show
		render json: @airport.dto_json, status: :ok
	end

	# POST
	def create
		@airport = Airport.new(
			icao: params["icao"],
			name: params["name"],
			location: params["location"],
			altitude: params["altitude"]
		)

		if not @airport.valid?
			raise
		end

		@airport.save

		render json: @airport.dto_json, status: :ok
	rescue
		render status: :bad_request
	end

	# PUT e PATCH
	def update
		@airport.update(
			name: params["name"],
			location: params["location"],
			altitude: params["altitude"]
    )
			
		render json: @airport.dto_json, status: :ok
	rescue
		render status: :bad_request
	end

	# DELETE
	def destroy
		if @airport.flights_source.blank? && @airport.flights_destination.blank?
			@airport.destroy

			render json: @airport.dto_json, status: :ok
			return
		end

		render status: :bad_request
	end

	private
	def set_airport
		airport_id = params[:icao]

		if airport_id.present?
			@airport = Airport.find(airport_id)
		else
			render status: :bad_request
		end
	end
end