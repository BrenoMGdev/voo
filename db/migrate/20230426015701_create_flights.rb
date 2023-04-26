class CreateFlights < ActiveRecord::Migration[7.0]
  def change
    create_table :flights, id: false do |t|
      t.integer :flight_number, primary_key: true
      t.belongs_to :plane, type: :string
      t.string :source_icao
      t.string :destination_icao
      t.time :tile_lenght
    end

    add_foreign_key :flights, :airports, column: 'source_icao', primary_key: 'icao'
    add_foreign_key :flights, :airports, column: 'destination_icao', primary_key: 'icao'

    #----------

    create_table :days_of_week do |t|
      t.string :description
    end

    create_table :days_of_week_flights, id: false do |t|
      t.belongs_to :flight, type: :integer
      t.belongs_to :day_of_week, type: :integer
    end

    #----------

    create_table :available_times do |t|
      t.time :description
    end

    create_table :available_times_flights, id: false do |t|
      t.belongs_to :flight, type: :integer
      t.belongs_to :available_time, type: :integer
    end
  end
end
