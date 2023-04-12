class Pilot < ApplicationRecord
	validates_presence_of :name, :password, :aircraft

	def to_json
	{
		id: self.id,
		name: self.name,
		password: self.password,
		planes: self.aircraft
	}
	end

end
