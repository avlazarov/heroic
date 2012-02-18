require 'spec_helper'

describe Monster do
  it { should validate_presence_of(:name) }
  it { should validate_numericality_of(:level) }
  it { should validate_numericality_of(:attack) }
  it { should validate_numericality_of(:defense) }
  it { should validate_numericality_of(:life) }
  it { should validate_numericality_of(:experience_given) }

  describe '#find_by_level_between' do
    it 'searches only for monsters between specified levels' do
      first_monster  = FactoryGirl.create :monster, level: 10
      second_monster = FactoryGirl.create :monster, level: 5

      found_monster = Monster.random_by_level_between 10, 15

      [first_monster].should include(found_monster)
      [second_monster].should_not include(found_monster)
    end
  end

  describe '#default' do
    it 'generates valid monster' do
      monster = Monster.default 1
      monster.should be_valid
      monster.should be_new_record
    end

    it 'generates monter with the same level' do
      monster = Monster.default 10
      monster.level.should == 10
    end
  end
end
