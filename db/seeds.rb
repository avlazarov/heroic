# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

PlayerClass.destroy_all
PlayerClass.create(:name => 'Barbarian', :attack => 20, :defense => 15, :experience_bonus => 0)
PlayerClass.create(:name => 'Paladin',   :attack => 15, :defense => 20, :experience_bonus => 2)
PlayerClass.create(:name => 'Sorcerer',  :attack => 5,  :defense => 20, :experience_bonus => 5)
PlayerClass.create(:name => 'Amazon',    :attack => 20, :defense => 15, :experience_bonus => 1)
PlayerClass.create(:name => 'Assassin',  :attack => 10, :defense => 15, :experience_bonus => 3)

# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

