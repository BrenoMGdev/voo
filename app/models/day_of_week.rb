class DayOfWeek < ApplicationRecord
	self.table_name = "days_of_week"

	has_and_belongs_to_many :flight

	validates_presence_of :description
end
