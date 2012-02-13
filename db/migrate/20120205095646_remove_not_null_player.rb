class RemoveNotNullPlayer < ActiveRecord::Migration
  def change
    change_column :accounts, :player_id, :integer, :null => true
  end
end
