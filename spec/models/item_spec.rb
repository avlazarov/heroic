require 'spec_helper'

describe Item do
  it { should belong_to(:inventory) }
  it { should validate_numericality_of(:defense) }
  it { should validate_numericality_of(:attack) }
  it { should validate_numericality_of(:life) }
  it { should validate_numericality_of(:experience_bonus) }
  it { should validate_presence_of(:name) }
  it { should_not validate_presence_of(:inventory) }

  it 'generates valid items' do
    Item.generate(10).should be_valid
  end
end
