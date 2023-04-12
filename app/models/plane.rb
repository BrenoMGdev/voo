class Plane < ApplicationRecord
    validates_presence_of :model, :date, :registration

    belongs_to :pilot
    
	def to_json
	{
		id: self.id,
		model: self.model,
		date: self.date,
        registration: :registration
	}
	end

end
