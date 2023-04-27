class FlightSerializer < ActiveModel::Serializer
  attributes :flight_number, :plane, :source, :destination, :days_of_week, :times, :tile_lenght

	def plane
		object.plane.dto_json
	end

	def source
		object.source.dto_json
	end

	def destination
		object.destination.dto_json
	end

	def days_of_week
		object.day_of_week.map(&:description)
	end

	def times
		object.available_time.map{|t| t.description.strftime("%Y-%m-%dT%H:%M.00Z") }
	end
end
