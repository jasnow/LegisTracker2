require 'spec_helper'

describe HouseCommittee, :type => :model do
  it { is_expected.to have_many( :bills ) }
end
