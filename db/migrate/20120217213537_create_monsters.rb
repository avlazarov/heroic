class CreateMonsters < ActiveRecord::Migration
  def change
    create_table :monsters do |t|
      t.string  :name
      t.integer :level, :default => 1
      t.integer :attack, :default => 0
      t.integer :defense, :default => 0
      t.integer :life, :default => 10
      t.integer :experience_given, :default => 100
      t.timestamps
    end
  end
end
