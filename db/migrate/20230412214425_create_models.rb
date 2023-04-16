class CreateModels < ActiveRecord::Migration[7.0]
  def change
    create_table :models, id: false do |t|
      t.string :id, primary_key: true
      t.string :description
      t.string :manufacturer
    end

    create_table :models_pilots, id: false do |t|
      t.belongs_to :pilot, type: :string
      t.belongs_to :model, type: :string
    end
  end
end
