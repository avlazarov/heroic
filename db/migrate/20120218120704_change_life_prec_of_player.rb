class ChangeLifePrecOfPlayer < ActiveRecord::Migration
  def change
    change_column :players, :current_life_percent, :decimal, :precision => 2, :scale => 2, :default => 100
  end
end
