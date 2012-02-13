class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :inventory_id
      t.string  :name
      t.integer :attack
      t.integer :defense
      t.integer :life
      t.integer :experience_bonus
      t.timestamps
    end
  end
end
