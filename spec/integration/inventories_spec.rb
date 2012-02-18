require 'spec_helper'

describe 'Inventory logics' do
  it 'creates one item after being created' do
    inventory = FactoryGirl.create :inventory
    inventory.items.should have(1).item
  end
end
