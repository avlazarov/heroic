class AddDefaultExperienceToPlayer < ActiveRecord::Migration
  def change
    change_column :players, :experience, :integer, :default => 0
  end
end
