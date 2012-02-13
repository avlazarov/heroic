class CreatePlayerClasses < ActiveRecord::Migration
  def change
    create_table :player_classes do |t|
      t.string :name
      t.integer :attack
      t.integer :defense
      t.integer :experience_bonus

      t.timestamps
    end
  end
end
