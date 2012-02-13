require 'spec_helper'

describe PlayerClass do
  it { should have_many(:players) }
  it { should validate_presence_of(:name) }
  it { should validate_numericality_of(:defense) }
  it { should validate_numericality_of(:attack) }
  it { should validate_numericality_of(:experience_bonus) }
end
