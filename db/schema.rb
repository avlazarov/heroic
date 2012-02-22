# encoding: UTF-8

ActiveRecord::Schema.define(:version => 20120218120900) do

  create_table "accounts", :force => true do |t|
    t.string   "username"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inventories", :force => true do |t|
    t.integer  "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", :force => true do |t|
    t.integer  "inventory_id"
    t.string   "name"
    t.integer  "attack",           :default => 0
    t.integer  "defense",          :default => 0
    t.integer  "life",             :default => 0
    t.integer  "experience_bonus", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "monsters", :force => true do |t|
    t.string   "name"
    t.integer  "level",            :default => 1
    t.integer  "attack",           :default => 0
    t.integer  "defense",          :default => 0
    t.integer  "life",             :default => 10
    t.integer  "experience_given", :default => 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "player_classes", :force => true do |t|
    t.string   "name"
    t.integer  "attack",           :default => 0
    t.integer  "defense",          :default => 0
    t.integer  "experience_bonus", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", :force => true do |t|
    t.integer  "account_id"
    t.integer  "experience",           :default => 0
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "player_class_id"
    t.integer  "potions",              :default => 0
    t.integer  "current_life_percent", :default => 100
  end

end
