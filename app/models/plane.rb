class Plane < ApplicationRecord
	belongs_to :pilot
	belongs_to :model

	validate :id_validation, on: :update
	validates_presence_of :id, :model_id, :pilot_id, :date, :registration

	def id_validation
    self.class.find(self.id).blank?
  end

	def to_json
		{
			id: self.id,
			model: (self.model.present? ? self.model.to_json : nil),
			date: self.date,
			registration: self.registration
		}
	end
end
