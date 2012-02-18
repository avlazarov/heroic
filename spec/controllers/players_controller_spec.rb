require 'spec_helper'

describe PlayersController do
  include Support::ControllerHelpers
  
  let(:account) { mock_model(Account) }
  let(:player) { mock_model(Player) }

  before do
    account.stub :player => player
  end

  describe 'GET show' do
    context 'when not logged in' do
      it 'denies access when not logged in' do
        get :show
        response.should deny_access
      end
    end

    context 'when logged in' do
      before do
        Account.stub :find => account
        log_in account
      end

      it 'assigns player to @player' do
        get :show
        assigns(:player).should == player
      end
    end
  end

  describe 'GET edit' do
    context 'when not logged in' do
      it 'denies access when not logged in' do
        get :edit
        response.should deny_access
      end
    end

    context 'when logged in' do
      before do
        Account.stub :find => account
        log_in account
      end

      it 'assigns player to @player' do
        get :edit
        assigns(:player).should == player
      end
    end
  end

  describe 'PUT update' do
    context 'when not logged in' do
      it 'denies access when not logged in' do
        put :update
        response.should deny_access
      end
    end

    context 'when logged in' do
      before do
        Account.stub :find => account
        log_in account
      end

      it 'attempts to update attributes of player' do
        player.should_receive(:update_attributes).with('attributes')
        put :update, :player => 'attributes'
      end

      context 'with invalid params[:player]' do
        before do
          player.stub :update_attributes => false
        end

        it 'renders edit form' do
          put :update
          response.should render_template('edit')
        end
      end

      context 'with valid params[:player]' do
        before do
          player.stub :update_attributes => true
        end

        it 'redirects to player' do
          put :update
          response.should redirect_to(player_path)
        end
      end
    end
  end

  describe 'GET resurrect' do
    context 'when not logged in' do
      it 'denies access when not logged in' do
        get :resurrect
        response.should deny_access
      end
    end

    context 'when logged in' do
      before do
        player.stub :dead?
        Account.stub :find => account
        log_in account
      end

      it 'checks if player is dead' do
        player.should_receive(:dead?)
        get :resurrect
      end

      context 'when player is dead' do
        before do
          player.stub :dead? => true
          player.stub :resurrect
          player.stub :save!
        end

        it 'resurrects player' do
          player.should_receive(:resurrect)
          get :resurrect
        end

        it 'saves player' do
          player.should_receive(:save!)
          get :resurrect
        end

        it 'redirects to player' do
          get :resurrect
          response.should redirect_to(player_path)
        end
      end
      
      context 'when player is not dead' do
        before do
          player.stub :dead? => false
        end

        it 'redirects to player path with error' do
          get :resurrect
          flash[:error].should be_present
          response.should redirect_to(player_path)
        end
      end
    end
  end

  
  describe 'GET use_potion' do
    context 'when not logged in' do
      it 'denies access when not logged in' do
        get :use_potion
        response.should deny_access
      end
    end

    context 'when logged in' do
      before do
        player.stub :can_use_potion?
        Account.stub :find => account
        log_in account
      end
      
      it 'checks if player can use potion' do
        player.should_receive(:can_use_potion?)
        get :use_potion
      end

      context 'when can use potion' do
        before do
          player.stub :can_use_potion? => true
          player.stub :use_potion
          player.stub :save
        end

        it 'uses potion' do
          player.should_receive(:use_potion)
          get :use_potion
        end

        it 'saves player' do
          player.should_receive(:save)
          get :use_potion
        end

        it 'redirects to player without error' do
          get :use_potion
          response.should redirect_without_error_to(player_path)
        end
      end

      context 'when cannot use potion' do
        before do
          player.stub :can_use_potion? => false
        end

        it 'redirects to player with error' do
          get :use_potion
          response.should redirect_with_error_to(player_path)
        end
      end
    end
  end
end
