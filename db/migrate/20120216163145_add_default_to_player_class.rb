class AddDefaultToPlayerClass < ActiveRecord::Migration
  def change
    change_column :player_classes, :experience_bonus, :integer, :default => 0
    change_column :player_classes, :attack, :integer, :default => 0
    change_column :player_classes, :defense, :integer, :default => 0
  end
end
