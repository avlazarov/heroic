# encoding: UTF-8

require 'spec_helper'

describe Account do
  it { should have_one(:player) }

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
end
