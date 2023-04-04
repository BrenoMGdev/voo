class AlterIdType < ActiveRecord::Migration[7.0]
  def up
    change_table :pilots do |t|
      t.change :id, :string
    end
  end

  def down
    change_table :pilots do |t|
      t.change :id, :integer
    end
  end
end
