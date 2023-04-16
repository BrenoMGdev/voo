class Plane < ApplicationRecord
	belongs_to :model

	validates_presence_of :model_id, :manufacturing_date, :registration

	def dto_json
    ActiveModelSerializers::SerializableResource.new(self, each_serializer: PlaneSerializer).as_json[:data][:attributes]
  end
end
