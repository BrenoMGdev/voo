class Airport < ApplicationRecord
	has_many :flights_source, class_name: 'Flight', foreign_key: 'source_icao'
	has_many :flights_destination, class_name: 'Flight', foreign_key: 'destination_icao'

	validates_presence_of :icao, :name, :latitude, :longitude, :altitude

	validates_uniqueness_of :icao, :name

	attr_accessor :location

	before_validation :convert_location

	def convert_location
		self.latitude = self.location.try(:[], 0)
		self.longitude = self.location.try(:[], 1)
	end

	def dto_json
    ActiveModelSerializers::SerializableResource.new(self, each_serializer: AirportSerializer).as_json[:data][:attributes]
  end
end
