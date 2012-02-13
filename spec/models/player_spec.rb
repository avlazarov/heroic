# encoding: UTF-8

require 'spec_helper'

describe Player do
  it { should belong_to(:player_class) }
  it { should belong_to(:account) }

  it { should have_one(:inventory) }
  it { should have_many(:items) }

  it { should validate_numericality_of(:potions) }
  it { should validate_numericality_of(:current_life_percent) }
  it { should validate_numericality_of(:experience) }

  it { should validate_format_of(:name).not_with('12D45').with_message('Only letters allowed') }
  it { should validate_format_of(:name).with('Stamat').with_message('Only letters allowed') }

  it { should_not allow_value('1Stamat').for(:name) }
  it { should_not allow_value('Stamat1').for(:name) }
  it { should_not allow_value('').for(:name) }
  it { should_not allow_value('Stamat Stamatov').for(:name) }
  it { should allow_value('Stamat').for(:name) }
  it { should allow_value('Стамат').for(:name) }
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:player_class).with_message('is not specified or does not exist') }

end
