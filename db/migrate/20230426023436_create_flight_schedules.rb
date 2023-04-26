class CreateFlightSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :flight_schedules, id: false do |t|
      t.string :id, primary_key: true
      t.belongs_to :flight, type: :integer
      t.belongs_to :pilot, type: :string
      t.datetime :date
    end
  end
end
