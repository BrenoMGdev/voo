class Flight < ApplicationRecord
	belongs_to :plane
	belongs_to :source, class_name: 'Airport', foreign_key: 'source_icao'
  belongs_to :destination, class_name: 'Airport', foreign_key: 'destination_icao'
	has_many :flight_schedule

	has_and_belongs_to_many :day_of_week
	has_and_belongs_to_many :days_of_week, class_name: :DayOfWeek

	has_and_belongs_to_many :available_time
	has_and_belongs_to_many :times, class_name: :AvailableTime

	validates_presence_of :flight_number, :plane_id, :source_icao, :destination_icao

	validates_uniqueness_of :flight_number

	def dto_json
    ActiveModelSerializers::SerializableResource.new(self, each_serializer: FlightSerializer).as_json[:data][:attributes]
  end
end
