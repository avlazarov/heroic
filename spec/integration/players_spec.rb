require 'spec_helper'

describe 'Player logics' do
  it 'creates inventrory after being created' do
    player = FactoryGirl.create :player
    player.inventory.should be_present
  end
end
