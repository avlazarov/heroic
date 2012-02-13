class AddDefaultItemAttributes < ActiveRecord::Migration
  def change
    change_column :items, :experience_bonus, :integer, :default => 0
    change_column :items, :attack, :integer, :default => 0
    change_column :items, :defense, :integer, :default => 0
    change_column :items, :life, :integer, :default => 0
  end
end
