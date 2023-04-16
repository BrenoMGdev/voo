class CreatePlanes < ActiveRecord::Migration[7.0]
  def change
    create_table :planes, id: false do |t|
      t.belongs_to :model, type: :string
      t.string :registration, primary_key: true
      t.date :manufacturing_date
    end
  end
end
