class ChangePotionsToPlayer < ActiveRecord::Migration
  def change
    change_column :players, :potions, :integer, :default => 0
  end
end
