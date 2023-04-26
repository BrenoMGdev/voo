class CreateAirports < ActiveRecord::Migration[7.0]
  def change
    create_table :airports, id: false do |t|
      t.string :icao, primary_key: true
      t.string :name
      t.float :latitude
      t.float :longitude
      t.float :altitude
    end
  end
end
