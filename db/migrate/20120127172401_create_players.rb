class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :account_id
      t.integer :inventory_id
      t.integer :experience
      t.string  :name
      t.timestamps
    end
  end
end
