class CreateModels < ActiveRecord::Migration[7.0]
  def change
    
    create_table :models, id:false do |t|
      t.string :id, primary_key: true
      t.string :model
      t.string :manufacturer
        
      t.timestamps
    end

    create_table :planes, id:false do |t|
      t.string :id, primary_key: true
      t.belongs_to :pilots, index: true
      t.belongs_to :models, index: true
      t.string :date
      t.string :registration
      
      t.timestamps
    end
  end
end
