class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.integer :player_id
      t.timestamps
    end
  end
end
