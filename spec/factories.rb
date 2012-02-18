FactoryGirl.define do
  factory :account do
    sequence(:username) { |n| "User_#{n}" }
    password 'valid_password'
  end

  factory :item do
    sequence(:name) { |n| "Item_#{n}" }
  end

  factory :inventory do
  end

  factory :player_class do
    sequence(:name) { |n| "PlayerClass_#{n}" }
  end

  factory :player do
    name 'Player'
    player_class
  end

  factory :monster do
    name 'Monster'
  end
end
