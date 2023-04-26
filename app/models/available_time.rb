class AvailableTime < ApplicationRecord
	self.table_name = "available_times"

	has_and_belongs_to_many :flight

	validates_presence_of :description
end
