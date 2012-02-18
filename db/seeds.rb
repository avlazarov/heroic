
PlayerClass.destroy_all
PlayerClass.create(:name => 'Barbarian', :attack => 20, :defense => 15, :experience_bonus => 0)
PlayerClass.create(:name => 'Paladin',   :attack => 15, :defense => 20, :experience_bonus => 2)
PlayerClass.create(:name => 'Sorcerer',  :attack => 5,  :defense => 20, :experience_bonus => 5)
PlayerClass.create(:name => 'Amazon',    :attack => 20, :defense => 15, :experience_bonus => 1)
PlayerClass.create(:name => 'Assassin',  :attack => 10, :defense => 15, :experience_bonus => 3)

Monster.destroy_all
Monster.create(:name => 'Ghost',   :level => 1,  :attack => 5,  :defense => 5,  :life => 10,  :experience_given => 100)
Monster.create(:name => 'Zombie',  :level => 7,  :attack => 10, :defense => 15, :life => 20,  :experience_given => 200)
Monster.create(:name => 'Demon',   :level => 14, :attack => 15, :defense => 5,  :life => 30,  :experience_given => 300)
Monster.create(:name => 'Archer',  :level => 21, :attack => 20, :defense => 10, :life => 40,  :experience_given => 400)
Monster.create(:name => 'Vampire', :level => 28, :attack => 25, :defense => 10, :life => 50,  :experience_given => 500)
Monster.create(:name => 'Undead',  :level => 35, :attack => 30, :defense => 15, :life => 60,  :experience_given => 600)
Monster.create(:name => 'Shaman',  :level => 42, :attack => 35, :defense => 15, :life => 70,  :experience_given => 700)
Monster.create(:name => 'Wraith',  :level => 49, :attack => 40, :defense => 15, :life => 80,  :experience_given => 800)
Monster.create(:name => 'Spider',  :level => 56, :attack => 45, :defense => 20, :life => 90,  :experience_given => 900)
Monster.create(:name => 'Fallen',  :level => 63, :attack => 50, :defense => 20, :life => 100, :experience_given => 1000)
Monster.create(:name => 'Rouge',   :level => 70, :attack => 55, :defense => 20, :life => 110, :experience_given => 1100)
Monster.create(:name => 'Skeleton',:level => 77, :attack => 60, :defense => 25, :life => 120, :experience_given => 1200)
Monster.create(:name => 'Mummy',   :level => 84, :attack => 65, :defense => 30, :life => 130, :experience_given => 1300)
Monster.create(:name => 'Zealot',  :level => 91, :attack => 70, :defense => 40, :life => 140, :experience_given => 1400)
Monster.create(:name => 'Beast',   :level => 98, :attack => 75, :defense => 45, :life => 150, :experience_given => 1500)
