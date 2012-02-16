require 'spec_helper'

describe PlayerClassesController do
  describe 'GET index' do
    let(:player_classes) { [double] }

    before do
      PlayerClass.stub :all => player_classes
    end

    it 'initializes player_classes with all player classes' do
      PlayerClass.should_receive(:all).and_return(player_classes)
      get :index
    end

    it 'assigns player_classes to @player_classes' do
      get :index
      assigns(:player_classes).should == player_classes
    end
  end
end
