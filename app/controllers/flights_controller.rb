class FlightsController < ApplicationController
	before_action :set_flight, only: [:show, :update, :destroy]

	# GET All
	def index
		flights = Flight.all.map{|f| f.dto_json }

		render json: flights, status: :ok
	end

	# GET com ID
	def show
		render json: @flight.dto_json, status: :ok
	end

	# POST
	def create
		plane = Plane.find_by(params["plane"].to_enum.to_h) if params["plane"].present?

		if params["source"].present?
			location = params["source"]["location"]

			source_airport = params["source"].to_enum.to_h

			source_airport.reject!{|k| k == "location" }
			source_airport.merge!({
				"latitude" => location.try(:[], 0),
				"longitude" => location.try(:[], 1)
			})

			source_airport = Airport.find_by(source_airport)
		end

		if params["destination"].present?
			location = params["destination"]["location"]

			destination_airport = params["destination"].to_enum.to_h

			destination_airport.reject!{|k| k == "location" }
			destination_airport.merge!({
				"latitude" => location.try(:[], 0),
				"longitude" => location.try(:[], 1)
			})

			destination_airport = Airport.find_by(destination_airport)
		end

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
		plane = Plane.find_by(params["plane"].to_enum.to_h) if params["plane"].present?
		
		if params["source"].present?
			location = params["source"]["location"]

			source_airport = params["source"].to_enum.to_h

			source_airport.reject!{|k| k == "location" }
			source_airport.merge!({
				"latitude" => location.try(:[], 0),
				"longitude" => location.try(:[], 1)
			})

			source_airport = Airport.find_by(source_airport)
		end

		if params["destination"].present?
			location = params["destination"]["location"]

			destination_airport = params["destination"].to_enum.to_h

			destination_airport.reject!{|k| k == "location" }
			destination_airport.merge!({
				"latitude" => location.try(:[], 0),
				"longitude" => location.try(:[], 1)
			})

			destination_airport = Airport.find_by(destination_airport)
		end

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
		@flight.destroy

		render json: @flight.dto_json, status: :ok
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