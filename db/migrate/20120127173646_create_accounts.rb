class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :player_id
      t.string  :username
      t.string  :password
      t.timestamps
    end
  end
end
