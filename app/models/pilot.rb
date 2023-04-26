require 'securerandom'

class Pilot < ApplicationRecord
	has_many :flight_schedule
	
	has_and_belongs_to_many :model
	has_and_belongs_to_many :abble_to_fligh, class_name: :Model

	validates_presence_of :name, :password

	before_create :set_id

	def set_id
    self.id = SecureRandom.uuid
  end

	def dto_json
    serializer = ActiveModelSerializers::SerializableResource.new(self, each_serializer: PilotSerializer).as_json

		{
			id: serializer[:data][:id]
		}.merge(
			serializer[:data][:attributes]
		)
  end
end
