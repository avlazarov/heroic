require 'spec_helper'

describe InventoriesController do
  include Support::ControllerHelpers

  describe 'GET show' do
    let(:account) { mock_model(Account) }
    let(:player) { double }
    let(:inventory) { double }
    let(:items) { [double, double] }

    context 'when logged in' do
      before do
        Account.stub :find => account
        account.stub :player => player
        player.stub :inventory => inventory
        inventory.stub :items => items

        log_in account
      end

      it 'assigns inventory to @inventory' do
        get :show
        assigns(:inventory).should == inventory
      end

      it 'assigns items to @items' do
        get :show
        assigns(:items).should == items
      end
    end
    
    context 'when not logged in' do
      it 'denies access' do
        get :show
        response.should deny_access
      end
    end
  end
end
