require 'spec_helper'

describe StatusCode, :type => :model do
  it { is_expected.to have_many(:statuses) }

  it "should provide description of status" do
    @status = FactoryBot.create( :status )
    expect(@status.status_code.description).to eq('House Prefiled')
  end
end
