class FlightScheduleSerializer < ActiveModel::Serializer
  attributes :id, :flight, :pilot, :date

	def flight
		object.flight.dto_json
	end

	def pilot
		object.pilot.dto_json
	end

	def date
		object.date.strftime("%d/%m/%Y %H:%M")
	end
end
