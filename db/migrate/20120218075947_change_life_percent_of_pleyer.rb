class ChangeLifePercentOfPleyer < ActiveRecord::Migration
  def change
    change_column :players, :current_life_percent, :decimal, :precision => 15, :scale => 2, :default => 100
  end

end
