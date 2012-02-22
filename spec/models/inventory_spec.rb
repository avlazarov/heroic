require 'spec_helper'

describe Inventory do
  let(:inventory) { FactoryGirl.create :inventory }

  it { should have_many(:items).dependent(:destroy) }
  it { should belong_to(:player) }

  it 'has one item after creation' do
    inventory.items.should have(1).item
  end
  
  it 'does not allow overflow with items' do
    inventory.stub :capacity => 1
    expect { inventory.add_item FactoryGirl.build(:item) }.to raise_error
  end

  it 'does not allow invalid items to be added' do
    expect { inventory.add_item Item.new }.to raise_error
  end

  it 'successfully adds valid item' do
    item = FactoryGirl.build :item
    expect { inventory.add_item item }.not_to raise_error
    item.save
    inventory.reload
    inventory.items.should include(item)
    inventory.items.should have(2).item # including initial
  end
end
