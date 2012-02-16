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

  factory :player do
    sequence(:name) { |n| "Player_#{n}" }
  end

  factory :player_class do
    sequence(:name) { |n| "PlayerClass_#{n}" }
  end
end
