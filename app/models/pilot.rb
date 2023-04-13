class Pilot < ApplicationRecord
	has_many :plane

	validate :id_validation, on: :update
	validates_presence_of :id, :name, :password

	def id_validation
    self.class.find(self.id).blank?
  end

	def to_json
		{
			id: self.id,
			name: self.name,
			password: self.password,
			planes: (self.plane.present? ? self.plane.map{|p| p.to_json } : [])
		}
	end
end
