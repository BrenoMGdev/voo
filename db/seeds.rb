# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Model
model_1 = Model.find_or_create_by(
	description: "Boeing 274",
	manufacturer: "Boeing"
)

model_2 = Model.find_or_create_by(
	description: "Boeing 307",
	manufacturer: "Boeing"
)


# Plane
Plane.find_or_create_by(
	model: model_1,
	registration: "123",
	manufacturing_date: "2000-04-01"
)

Plane.find_or_create_by(
	model: model_2,
	registration: "321",
	manufacturing_date: "2000-04-01"
)


# Pilot
pilot_1 = Pilot.find_or_create_by(
	name: "Zé",
	password: "123"
) do |pilot|
	pilot.model = [
		model_1,
		model_2
	]
end

pilot_2 = Pilot.find_or_create_by(
	name: "Zezinho",
	password: "321"
) do |pilot|
	pilot.model = [
		model_1,
		model_2
	]
end