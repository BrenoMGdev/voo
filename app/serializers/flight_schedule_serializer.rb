class FlightScheduleSerializer < ActiveModel::Serializer
  attributes :id, :flight, :pilot, :date

	def flight
		object.flight.dto_json
	end

	def pilot
		object.pilot.dto_json
	end

	def date
		object.date.strftime("%Y-%m-%dT%H:%M.00Z")
	end
end
