class CreatePilots < ActiveRecord::Migration[7.0]
  def change
    create_table :pilots do |t|
      t.string :name
      t.string :password
      t.string :aircraft
      
      t.timestamps
    end
  end
end
