class AddNotNullPlayerToAccount < ActiveRecord::Migration
  def change
    change_column :accounts, :player_id, :integer, :null => false
  end
end
