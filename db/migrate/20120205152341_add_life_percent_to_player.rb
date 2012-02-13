class AddLifePercentToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :current_life_percent, :integer, :default => 100
  end
end
