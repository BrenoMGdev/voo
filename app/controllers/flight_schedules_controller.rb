class FlightSchedulesController < ApplicationController
	before_action :set_flight_schedule, only: [:show, :update, :destroy]

	# GET All
	def index
		where = ["1=1"]

		where << "sources.icao = '#{ params["source"] }'" if params["source"].present?
		where << "destinations.icao = '#{ params["destination"] }'" if params["destination"].present?

		date = DateTime.parse(params["date"]) if params["date"].present?
		if date.present?
			if params["range_start"].blank?
				where << "flight_schedules.date >= '#{ date.strftime("%Y-%m-%d 00:00:00") }'" if params["range_start"].present?
			else
				where << "flight_schedules.date >= '#{ (date - params["range_start"].to_i.days).strftime("%Y-%m-%d 00:00:00") }'"
			end

			if params["range_end"].blank?
				where << "flight_schedules.date <= '#{ date.strftime("%Y-%m-%d 23:59:59")  }'" if params["range_end"].present?
			else
				where << "flight_schedules.date <= '#{ (date + params["range_end"].to_i.days).strftime("%Y-%m-%d 23:59:59") }'"
			end
		end

		where << "pilots.id = '#{ params["pilot"] }'" if params["pilot"].present?
		where << "planes.registration = '#{ params["plane"] }'" if params["plane"].present?
		where << "models.description = '#{ params["model"] }'" if params["model"].present?

		flight_schedules = FlightSchedule
			.joins("
				INNER JOIN pilots ON pilots.id = flight_schedules.pilot_id
				INNER JOIN flights ON flights.flight_number = flight_schedules.flight_id
				INNER JOIN airports sources ON sources.icao = flights.source_icao
				INNER JOIN airports destinations ON destinations.icao = flights.destination_icao
				INNER JOIN planes ON planes.registration = flights.plane_id
				INNER JOIN models ON models.id = planes.model_id
			")
			.where(where.join(" AND "))
			.map{|fs| fs.dto_json }

		render json: flight_schedules, status: :ok
	end

	# GET com ID
	def show
		render json: @flight_schedule.dto_json, status: :ok
	end

	# POST
	def create
		flight = Flight.find(params["flight"].try(:[], "flight_number")) if params["flight"].present?
		pilot = Pilot.find(params["pilot"].try(:[], "id")) if params["pilot"].present?

		@flight_schedule = FlightSchedule.new(
			flight: flight,
			pilot: pilot,
			date: params["date"]
		)

		@flight_schedule.save

		render json: @flight_schedule.dto_json, status: :ok
	rescue
		render status: :bad_request
	end

	# PUT e PATCH
	def update
		flight = Flight.find(params["flight"].try(:[], "flight_number")) if params["flight"].present?
		pilot = Pilot.find(params["pilot"].try(:[], "id")) if params["pilot"].present?

		@flight_schedule.update(
			flight: flight,
			pilot: pilot,
			date: params["date"]
    )
			
		render json: @flight_schedule.dto_json, status: :ok
	rescue
		render status: :bad_request
	end

	# DELETE
	def destroy
		@flight_schedule.destroy

		render json: @flight_schedule.dto_json, status: :ok
	end

	private
	def set_flight_schedule
		flight_schedule_id = params[:id]

		if flight_schedule_id.present?
			@flight_schedule = FlightSchedule.find(flight_schedule_id)
		else
			render status: :bad_request
		end
	end
end