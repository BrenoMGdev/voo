class Pilot < ApplicationRecord
	validate :validate_fields

	def validate_fields
		fields = [:name, :password, :aircraft]
		blank_message = I18n.t('errors.messages.blank')

		fields.each do |field|
			self.errors.add(Pilot.human_attribute_name(field), blank_message) if self.send(field).blank?
		end
	end

	def to_json
		{
			id: self.id,
			nome: self.name,
			senha: self.password,
			aeronave: self.aircraft
		}
	end
end
