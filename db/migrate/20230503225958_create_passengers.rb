class CreatePassengers < ActiveRecord::Migration[7.0]
  def change
    create_table :passengers, id: false do |t|
      t.string :id, primary_key: true
      t.string :cpf
      t.string :passport
      t.string :country
      t.string :name
      t.string :surname
      t.string :password
      t.integer :miles, default: 0

      t.timestamps
    end
  end
end
