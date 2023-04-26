class AirportSerializer < ActiveModel::Serializer
  attributes :icao, :name, :location, :altitude

	def location
    [
      object.latitude,
      object.longitude
    ]
	end
end
