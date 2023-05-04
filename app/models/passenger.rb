class Passenger < ApplicationRecord
  validates_uniqueness_of :cpf, :passport

  before_create :set_id

  def set_id
    self.id = SecureRandom.uuid
  end

  def dto_json
    serializer = ActiveModelSerializers::SerializableResource.new(self, each_serializer: PassengerSerializer).as_json[:data][:attributes]
  end
end
