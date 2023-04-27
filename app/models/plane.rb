class Plane < ApplicationRecord
	belongs_to :model

	validates_presence_of :registration, :manufacturing_date, :model_id

	validates_uniqueness_of :registration

	def dto_json
    ActiveModelSerializers::SerializableResource.new(self, each_serializer: PlaneSerializer).as_json[:data][:attributes]
  end
end
