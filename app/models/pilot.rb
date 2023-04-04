class Pilot < ApplicationRecord
	validates_presence_of :name, :password, :aircraft

	NAME_CONVERT = {
		id: :id,
		name: :name,
		password: :password,
		planes: :aircraft
	}

	def to_json
		NAME_CONVERT.map{|k, v| [k, self.send(v)] }.to_h
	end

	def self.prepare_params(params)
		NAME_CONVERT.map{|k, v| [v, params[k]] }.to_h
	end
end
