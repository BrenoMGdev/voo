class Model < ApplicationRecord
  has_many :plane

  validate :id_validation, on: :update
  validates_presence_of :id, :model, :manufacturer
  
  def id_validation
    self.class.find(self.id).blank?
  end

	def to_json
    {
      id: self.id,
      model: self.model,
      manufacturer: self.manufacturer
    }
	end
end
