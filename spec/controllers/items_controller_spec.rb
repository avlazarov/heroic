require 'spec_helper'

describe ItemsController do
  include Support::ControllerHelpers

  describe 'DELETE items' do
    let(:account) { mock_model(Account) }
    let(:item) { Factory.stub :item }
    let(:player) { mock_model(Player) }

    context 'when logged in' do
      before do
        Account.stub :find => account
        account.stub :player => player
        player.stub :items => []
        Item.stub :find => item
        item.stub :destroy

        log_in account
      end

      it 'initializes item with id' do
        Item.should_receive(:find).with(item.id.to_s).and_return(item)
        delete :destroy, :id => item.id.to_s
      end

      context 'when item does not belong to player' do
        it 'does not destroy the item' do
          item.should_not_receive(:destroy)
          delete :destroy, :id => item.id
        end

        it 'redirects to inventory with error' do
          delete :destroy, :id => item.id
          response.should redirect_with_error_to(inventory_path)
        end
      end

      context 'when item belongs to player' do  
        before do
          player.stub :items => [item]
        end

        it 'destroys the item' do
          item.should_receive(:destroy)
          delete :destroy, :id => item.id
        end

        it 'redirects to inventory without error' do
          delete :destroy, :id => item.id
          response.should redirect_without_error_to(inventory_path)
        end
      end
    end

    context 'when not logged in' do
      it 'denies access' do
        delete :destroy, :id => item.id
        response.should deny_access
      end
    end
  end
end
