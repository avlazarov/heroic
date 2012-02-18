# encoding: UTF-8

require 'spec_helper'

describe Player do
  it { should belong_to(:player_class) }
  it { should belong_to(:account).dependent(:destroy) }

  it { should have_one(:inventory).dependent(:destroy) }
  it { should have_many(:items) }

  it { should validate_numericality_of(:potions) }
  it { should validate_numericality_of(:current_life_percent) }
  it { should validate_numericality_of(:experience) }

  it { should validate_format_of(:name).not_with('12D45').with_message('only letters allowed') }
  it { should validate_format_of(:name).with('Stamat').with_message('only letters allowed') }

  it { should_not allow_value('1Stamat').for(:name) }
  it { should_not allow_value('Stamat1').for(:name) }
  it { should_not allow_value('').for(:name) }
  it { should_not allow_value('Stamat Stamatov').for(:name) }
  it { should allow_value('Stamat').for(:name) }
  it { should allow_value('Стамат').for(:name) }
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:player_class).with_message('is not specified or does not exist') }

  describe '#use_potion' do
    context 'when dead' do
      let(:player) { FactoryGirl.create :dead_player }

      it 'cannot use potion' do
        player.can_use_potion?.should be_false
      end
    end

    context 'when alive' do
      context 'when has 0 potions' do
        let(:player) { FactoryGirl.create :player, current_life_percent: 1, potions: 0 }

        it 'cannot use potion' do
          player.can_use_potion?.should be_false
        end
      end

      context 'when has more than 0 potions' do
        let(:player) { FactoryGirl.create :player, current_life_percent: 1, potions: 1 }

        it "can use potion if current life percent is less than #{Player::MAX_LIFE_PERCENT}" do
          player.can_use_potion?.should be_true
        end

        it "cannot use potion if current life percent is #{Player::MAX_LIFE_PERCENT}" do
          player.current_life_percent = Player::MAX_LIFE_PERCENT
          player.can_use_potion?.should be_false
        end

        it 'decreases potions count by 1' do
          potions_before = player.potions
          player.use_potion
          player.potions.should == potions_before - 1
        end

        it "will not allow current life percent to acceed #{Player::MAX_LIFE_PERCENT}" do
          player.current_life_percent = Player::MAX_LIFE_PERCENT - 1
          player.use_potion
          player.current_life_percent.should be_between(Player::MIN_LIFE_PERCENT, Player::MAX_LIFE_PERCENT)
        end
      end
    end
  end

  describe '#resurrect' do
    context 'when alive' do
      let(:player) { FactoryGirl.create :player }

      it 'cannot be ressurected' do
        player.resurrect.should be_false
      end
    end

    context 'when dead' do
      let(:player) { FactoryGirl.create :dead_player, experience: 10000 }

      it "restores current life percent to #{Player::MAX_LIFE_PERCENT}%" do
        player.resurrect
        player.current_life_percent.should == 100
      end
      
      it "looses #{Rails.application.config.experience_percent_lost}% from current experience" do
        experience_after = (player.experience * (1 - Rails.application.config.experience_percent_lost * 0.01)).to_i
        player.resurrect
        player.experience.should == experience_after
      end 
    end
  end

  describe 'stats' do
    let(:player) { FactoryGirl.create :player, experience: 10000 }
    let(:items) { FactoryGirl.build_list :item, 3 }

    def total_for(attribute)
      items.map(&attribute).inject { |sum, current| sum + current }
    end

    before do
      player.stub :items => items
      player.player_class.stub :attack => 0
      player.player_class.stub :defense => 0
      player.player_class.stub :experience_bonus => 0
    end

    it 'calculates defense correctly' do
      player.defense.should == total_for(:defense)
    end

    it 'calculates attack correctly' do
      player.attack.should == total_for(:attack)
    end

    it 'calculates experience bonus correctly' do
      player.defense.should == total_for(:experience_bonus)
    end

    it 'calculates current life correctly' do
      total_life = total_for(:life)
      expected = (0.01 * total_life * player.current_life_percent).to_i
      player.current_life.should == expected
    end

    it 'calculates total life correctly' do
      player.total_life.should == total_for(:life)
    end

    it 'calculates level correctly' do
      expected_level = 1 + player.experience / Rails.application.config.experience_per_level
      player.level.should == expected_level
    end
  end

  describe '#add_item' do
    let(:player) { FactoryGirl.create :player }

    before do 
      player.inventory.stub :add_item
    end

    it 'uses Inventory#add_item' do
      player.inventory.should_receive(:add_item)
      player.add_item double
    end
  end
  
  describe '#decrease_life_with' do
    let(:player) { FactoryGirl.create :player, current_life_percent: 50 }

    before do
      player.stub :items => [FactoryGirl.build(:item, life: 25)] 
    end

    it 'descreases life with specified amount' do
      life_before = player.current_life
      player.decrease_life_with 10
      player.current_life.should == life_before - 10 
    end

    it 'will not result in invalid player life' do
      player.decrease_life_with 1000
      player.should be_valid
    end

    it 'will not update life if amount param is negative' do
      life_percent_before = player.current_life_percent
      player.decrease_life_with -10
      player.current_life_percent.should == life_percent_before
    end
  end

  describe '#receive_experience' do
    let(:player) { FactoryGirl.create :player, experience: 200 }

    it 'increases experience with specified amount' do
      expericence_before = player.experience
      player.receive_experience 100
      player.experience.should == expericence_before + 100 * (1 + player.experience_bonus)
    end

    it 'does not change experience on negative amount param' do
      experience_before = player.experience
      player.receive_experience -10
      player.experience.should == experience_before # dont use _changed?
    end
  end
end
