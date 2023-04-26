class FlightsController < ApplicationController
	before_action :set_flight, only: [:show, :update, :destroy]

	# GET All
	def index
		where = ["1=1"]

		where << "sources.icao = '#{ params["source"] }'" if params["source"].present?
		where << "destinations.icao = '#{ params["destination"] }'" if params["destination"].present?

		flights = Flight
			.joins("
				INNER JOIN airports sources ON sources.icao = flights.source_icao
				INNER JOIN airports destinations ON destinations.icao = flights.destination_icao
			")
			.where(where.join(" AND "))
			.map{|f| f.dto_json }

		render json: flights, status: :ok
	end

	# GET com ID
	def show
		render json: @flight.dto_json, status: :ok
	end

	# POST
	def create
		plane = Plane.find(params["plane"].try(:[], "registration")) if params["plane"].present?
		source_airport = Airport.find(params["source"].try(:[], "icao")) if params["source"].present?
		destination_airport = Airport.find(params["destination"].try(:[], "icao")) if params["destination"].present?


		if params["days_of_week"].present?
			days_of_week = params["days_of_week"].map do |day_of_week|
				DayOfWeek.find_or_create_by(
					description: day_of_week
				)
			end
		end

		if params["times"].present?
			times = params["times"].map do |time|
				AvailableTime.find_or_create_by(
					description: time
				)
			end
		end

		@flight = Flight.new(
			flight_number: params["flight_number"],
			plane: plane,
			source: source_airport,
			destination: destination_airport,
			day_of_week: days_of_week,
			available_time: times,
			tile_lenght: params["tile_lenght"]
		)

		@flight.save

		render json: @flight.dto_json, status: :ok
	rescue
		render status: :bad_request
	end

	# PUT e PATCH
	def update
		plane = Plane.find(params["plane"].try(:[], "registration")) if params["plane"].present?
		source_airport = Airport.find(params["source"].try(:[], "icao")) if params["source"].present?
		destination_airport = Airport.find(params["destination"].try(:[], "icao")) if params["destination"].present?

		if params["days_of_week"].present?
			days_of_week = params["days_of_week"].map do |day_of_week|
				DayOfWeek.find_or_create_by(
					description: day_of_week
				)
			end
		end

		if params["times"]
			times = params["times"].map do |time|
				AvailableTime.find_or_create_by(
					description: time
				)
			end
		end

		@flight.update(
			plane: plane,
			source: source_airport,
			destination: destination_airport,
			day_of_week: days_of_week,
			available_time: times,
			tile_lenght: params["tile_lenght"]
    )
			
		render json: @flight.dto_json, status: :ok
	rescue
		render status: :bad_request
	end

	# DELETE
	def destroy
		if @flight.flight_schedule.blank?
			@flight.destroy

			render json: @flight.dto_json, status: :ok
		end

		render status: :bad_request
	end

	private
	def set_flight
		flight_id = params[:flight_number]

		if flight_id.present?
			@flight = Flight.find(flight_id)
		else
			render status: :bad_request
		end
	end
end