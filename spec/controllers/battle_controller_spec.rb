require 'spec_helper'

describe BattleController do
  include Support::ControllerHelpers

  describe 'GET start' do
    context 'when not logged in' do
      it 'denies access' do
        get :start
        response.should deny_access
      end
    end

    context 'when logged in' do
      let(:account) { mock_model(Account) }
      let(:player) { Factory.stub :player } 

      before do
        Account.stub :find => account
        account.stub :player => player
        log_in account
      end

      context 'when dead' do
        before do
          player.stub :dead? => true
        end

        it 'redirects to player with error' do
          get :start
          response.should redirect_with_error_to(player_path)
        end
      end

      context 'when alive' do
        let(:monster) { Factory.stub :monster }
        let(:item) { [Factory.stub(:item)] }

        before do
          player.stub :level => 10
          player.stub :dead? => false
          player.stub :save # no database save for stubbed models
          player.stub :reload
          player.stub :items => []
          player.stub :add_item

          Monster.stub :default => monster
          Item.stub :generate => item

          item.stub :save
        end

        it 'searches for random monster' do
          Monster.stub :random_by_level_between => monster
          Monster.should_receive(:random_by_level_between).with(5, 12).and_return(monster)

          get :start
        end

        it 'uses default monster when no monster found' do
          Monster.should_receive(:default).with(player.level).and_return(monster)
          get :start
        end

        it 'will change current live percent' do
          player.should_receive(:decrease_life_with)
          get :start
        end

        it 'will generate items' do
          random = double
          Random.stub :new => random
          random.stub :rand => 1
          Item.should_receive(:generate).with(monster.level).and_return(item)

          get :start
        end

        it 'will change potions count' do
          player.should_receive(:potions=)
          get :start
        end

        it 'will receive experience with monster experience' do
          player.should_receive(:receive_experience).with(monster.experience_given)
          get :start
        end

        it 'will get experience given from monster' do
          monster.stub :experience_given => 1000 # if not stubbed returns nil
          monster.should_receive(:experience_given)
          get :start
        end

        it 'assigns player to @player' do
          get :start
          assigns(:player).should == player
        end

        it 'assigns monster to @monster' do
          get :start
          assigns(:monster).should == monster
        end
      end
    end
  end
end
