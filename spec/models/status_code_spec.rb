require 'spec_helper'

describe StatusCode do
  it { should have_many(:statuses) }

  it "should provide description of status" do
    @status = FactoryGirl.create( :status )
    expect(@status.status_code.description).to eq('House Prefiled')
  end
end
