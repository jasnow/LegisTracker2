require 'spec_helper'

describe SenateCommittee, :type => :model do
  it { is_expected.to have_many( :bills ) }
end
