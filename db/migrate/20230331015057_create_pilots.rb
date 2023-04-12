class CreatePilots < ActiveRecord::Migration[7.0]
  def change
    create_table :pilots, id:false do |t|
      t.string :id, primary_key: true
      t.string :name
      t.string :password
      
      t.timestamps
    end
  end
end
