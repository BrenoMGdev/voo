class Model < ApplicationRecord
    # validates_presence_of :model, :manufacturer

    belongs_to :plane

	def to_json
	{
        id: self.id,
        model: self.model,
        manufacturer: self.manufacturer,
    }
	end

end
