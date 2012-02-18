class ChangeIntLifePercOfPlayer < ActiveRecord::Migration
  def change
    change_column :players, :current_life_percent, :integer, :default => 100
  end
end
