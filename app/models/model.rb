require 'securerandom'

class Model < ApplicationRecord
  has_and_belongs_to_many :pilot
  has_many :planes

  validates_presence_of :description, :manufacturer

  validates_uniqueness_of :description

  before_create :set_id

  def set_id
    self.id = SecureRandom.uuid
  end

  def dto_json
    serializer = ActiveModelSerializers::SerializableResource.new(self, each_serializer: ModelSerializer).as_json

    {
			id: serializer[:data][:id]
		}.merge(
			serializer[:data][:attributes]
		)
  end
end
