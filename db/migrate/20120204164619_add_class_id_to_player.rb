class AddClassIdToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :player_class_id, :integer
  end
end
