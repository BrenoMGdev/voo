# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_05_03_225958) do
  create_table "airports", primary_key: "icao", id: :string, force: :cascade do |t|
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.float "altitude"
  end

  create_table "available_times", force: :cascade do |t|
    t.time "description"
  end

  create_table "available_times_flights", id: false, force: :cascade do |t|
    t.integer "flight_id"
    t.integer "available_time_id"
    t.index ["available_time_id"], name: "index_available_times_flights_on_available_time_id"
    t.index ["flight_id"], name: "index_available_times_flights_on_flight_id"
  end

  create_table "days_of_week", force: :cascade do |t|
    t.string "description"
  end

  create_table "days_of_week_flights", id: false, force: :cascade do |t|
    t.integer "flight_id"
    t.integer "day_of_week_id"
    t.index ["day_of_week_id"], name: "index_days_of_week_flights_on_day_of_week_id"
    t.index ["flight_id"], name: "index_days_of_week_flights_on_flight_id"
  end

  create_table "flight_schedules", id: :string, force: :cascade do |t|
    t.integer "flight_id"
    t.string "pilot_id"
    t.datetime "date"
    t.index ["flight_id"], name: "index_flight_schedules_on_flight_id"
    t.index ["pilot_id"], name: "index_flight_schedules_on_pilot_id"
  end

  create_table "flights", primary_key: "flight_number", force: :cascade do |t|
    t.string "plane_id"
    t.string "source_icao"
    t.string "destination_icao"
    t.time "tile_lenght"
    t.index ["plane_id"], name: "index_flights_on_plane_id"
  end

  create_table "models", id: :string, force: :cascade do |t|
    t.string "description"
    t.string "manufacturer"
  end

  create_table "models_pilots", id: false, force: :cascade do |t|
    t.string "pilot_id"
    t.string "model_id"
    t.index ["model_id"], name: "index_models_pilots_on_model_id"
    t.index ["pilot_id"], name: "index_models_pilots_on_pilot_id"
  end

  create_table "passengers", force: :cascade do |t|
    t.string "cpf"
    t.string "passport"
    t.string "country"
    t.string "name"
    t.string "surname"
    t.string "password"
    t.integer "miles", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pilots", id: :string, force: :cascade do |t|
    t.string "name"
    t.string "password"
  end

  create_table "planes", primary_key: "registration", id: :string, force: :cascade do |t|
    t.date "manufacturing_date"
    t.string "model_id"
    t.index ["model_id"], name: "index_planes_on_model_id"
  end

  add_foreign_key "flights", "airports", column: "destination_icao", primary_key: "icao"
  add_foreign_key "flights", "airports", column: "source_icao", primary_key: "icao"
end
