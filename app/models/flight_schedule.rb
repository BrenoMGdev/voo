require 'securerandom'

class FlightSchedule < ApplicationRecord
	belongs_to :flight
	belongs_to :pilot

	validates_presence_of :date

	before_create :set_id

	def set_id
    self.id = SecureRandom.uuid
  end

	def dto_json
    serializer = ActiveModelSerializers::SerializableResource.new(self, each_serializer: FlightScheduleSerializer).as_json

		{
			id: serializer[:data][:id]
		}.merge(
			serializer[:data][:attributes]
		)
  end
end
