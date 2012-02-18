# encoding: UTF-8

require 'spec_helper'

describe PlayerClass do
  it { should have_many(:players).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should validate_numericality_of(:defense) }
  it { should validate_numericality_of(:attack) }
  it { should validate_numericality_of(:experience_bonus) }

  it { should validate_format_of(:name).not_with('1CLass').with_message('only letters allowed') }
  it { should validate_format_of(:name).with('Class').with_message('only letters allowed') }

  it { should_not allow_value('1Class').for(:name) }
  it { should_not allow_value('Class1').for(:name) }
  it { should_not allow_value('').for(:name) }
  it { should_not allow_value('Cool Class').for(:name) }
  it { should allow_value('barbarian').for(:name) }
  it { should allow_value('Варварин').for(:name) }
end
