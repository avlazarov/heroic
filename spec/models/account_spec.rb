# encoding: UTF-8

require 'spec_helper'

describe Account do
  include AccountsHelper

  it { should have_one(:player).dependent(:destroy) }

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password) }

  it { should ensure_length_of(:username).is_at_least(2).is_at_most(30) }
  it { should ensure_length_of(:password).is_at_least(6).is_at_most(30) }

  it { should allow_value('An').for(:username) }
  it { should allow_value('Кубрат').for(:username) }
  it { should allow_value('Кубрат_11').for(:username) }

  it { should_not allow_value('1An').for(:username) }
  it { should_not allow_value('Хан Крум').for(:username) }
  
  it { should allow_value('ultra_secret_password!').for(:password) }
  it { should_not allow_value('pass').for(:password) }

  describe 'Password encryptions' do
    let(:password) { 'ultrasecret' }

    it 'encypts password on save' do
      account = FactoryGirl.create :account, password: password
      account.password.should == encrypt(password)
    end

    it 'will not re-encypt password if password has not been changed' do
      account = FactoryGirl.create :account, password: password

      original_password, account.password = account.password, 'extreme_secret'
      account.password = original_password
      account.save

      account.password.should == encrypt(password)
    end
  end
end
