class AddPotionsToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :potions, :integer
  end
end
