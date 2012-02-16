require 'spec_helper'

describe AccountsController do
  include AccountsHelper
  include Support::ControllerHelpers

  let(:account)  { double }
  let(:player)  { double }

  describe 'GET login' do
    before do
      Account.stub :new => account
    end

    it 'initializes empty account' do
      Account.should_receive(:new).with(no_args())
      get :login
    end

    it 'assigns account to @account' do
      get :login
      assigns(:account).should == account
    end
  end

  describe 'POST process_login' do
    let(:account) { mock_model(Account) }

    before do
      Account.stub :find_by_username_and_password => account
    end

    it 'searches for account with param[:account][:username] and param[:account][:password]' do
      Account.should_receive(:find_by_username_and_password).with('username', encrypt('password')).and_return(account)
      post :process_login, :account => {:username => 'username', :password => 'password'}
    end

    it 'logs in account' do
      post :process_login, :account => {}
      account.should be_logged_in
    end

    it 'redirects to player path on success' do
      post :process_login, :account => {}
      response.should redirect_to(player_path)
    end

    it 'redirects to account login on failed login' do
      Account.stub :find_by_username_and_password => false
      post :process_login, :account => {}
      response.should deny_access
    end
  end

  describe 'GET logout' do
    let(:account) { mock_model(Account) }

    before do
      Account.stub :find => account
    end

    it 'destroys session' do
      log_in account
      get :logout
      account.should_not be_logged_in
    end

    it 'redirects to login' do
      get :logout
      response.should redirect_to(login_account_path)
    end
  end

  describe 'GET show' do
    let(:account) { mock_model(Account) }

    before do
      Account.stub :find => account
    end

    context 'when logged in' do
      before do
        log_in account
      end

      it 'assigns account to @account' do
        get :show
        assigns(:account).should == account
      end
    end

    context 'when not logged in' do
      it 'denies access' do
        get :show
        response.should deny_access
      end
    end
  end

  describe 'GET new' do
    before do
      Account.stub :new => account
      Player.stub  :new => player
    end

    it 'initializes empty account' do
      Account.should_receive(:new).with(no_args())
      get :new
    end

    it 'initializes empty player' do
      Player.should_receive(:new).with(no_args())
      get :new
    end

    it 'assigns account to @account' do
      get :new
      assigns(:account).should == account
    end
    
    it 'assigns player to @player' do
      get :new
      assigns(:player).should == player
    end
  end

  describe 'GET edit' do
    let(:account) { mock_model(Account) }

    before do
      Account.stub :find => account
    end

    context 'when logged in' do
      before do
        log_in account
      end

      it 'assigns account to @account' do
        get :edit
        assigns(:account).should == account
      end
    end
    
    context 'when not logged in' do
      it 'redirects to account login when not loged in' do
        get :edit
        response.should deny_access
      end
    end
  end

  describe 'POST create' do
    before do
      Account.stub :new => account
      account.stub :save => true
      account.stub :build_player => player
      player.stub  :save => true
    end

    it 'initializes an account with params[:account]' do
      Account.should_receive(:new).with('attributes').and_return(account)
      post :create, :account => 'attributes'
    end

    it 'assigns account to @account' do
      post :create
      assigns(:account).should == account
    end

    it 'builds a player with params[:player]' do
      account.should_receive(:build_player).with('attributes').and_return(player)
      post :create, :player => 'attributes'
    end

    it 'saves the initialized account' do
      account.should_receive(:save)
      post :create
    end

    it 'saves the build player' do
      player.should_receive(:save)
      post :create
    end

    it 'redirects to account login on successful create' do
      post :create
      response.should redirect_to(login_account_path)
    end

    it 'destroys account if player information is invalid' do
      player.stub :save => false
      account.should_receive(:destroy)
      post :create
    end
  end

  describe 'DELETE destroy' do
    let(:account)  { mock_model(Account, :destroy => true) }
    context 'when logged in' do
      before do
        log_in account
        Account.stub :find => account
      end

      it 'deletes the account' do
        account.should_receive(:destroy)
        delete :destroy
      end

      it 'redirects to account login' do
        delete :destroy
        response.should redirect_to(login_account_path)
      end
    end

    context 'when not logged in' do
      it 'denies access' do
        delete :destroy
        response.should deny_access
      end
    end
  end

  describe 'PUT update' do
    let(:account)  { mock_model(Account, :update_attributes => true) }

    context 'when logged in' do
      before do
        Account.stub :find => account
        log_in account
      end

      context 'when successful' do
        it 'updates account' do
          account.should_receive(:update_attributes).with('attributes').and_return(true)
          put :update, :account => 'attributes'
        end

        it 'redirects to account edit' do
          put :update
          response.should redirect_to(edit_account_path)
        end
      end

      context 'when unsuccessful' do
        it 'renders edit' do
          account.stub :update_attributes => false
          put :update
          response.should render_template(:edit)
        end
      end
    end

    context 'when not logged in' do
      it 'denies access' do
        put :update
        response.should deny_access
      end
    end
  end
end
