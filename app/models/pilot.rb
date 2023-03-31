class Pilot < ApplicationRecord
	validates_presence_of :name, :password, :aircraft

	def to_json
		{
			id: self.id,
			nome: self.name,
			senha: self.password,
			aeronave: self.aircraft
		}
	end
end
