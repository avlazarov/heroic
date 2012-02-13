class RemoveWrongIds < ActiveRecord::Migration
  def change
    remove_column :accounts, :player_id
    remove_column :players,  :inventory_id
  end
end
