FactoryGirl.define do
  sequence(:name) { |n| "Autogenerated_item_#{n}" }

  factory :item do
    name
  end

  factory :inventory do
  end

  factory :player do
  end

  factory :player_class do
  end

  factory :account do
  end
end
