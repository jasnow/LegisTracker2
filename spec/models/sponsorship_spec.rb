require 'spec_helper'

describe Sponsorship do
  it { should belong_to( :bill ) }
  it { should belong_to( :member ) }

  describe "primary named scope" do
    before(:each) do
      FactoryGirl.create( :sponsorship, :seq => 1 )
      FactoryGirl.create( :sponsorship, :seq => 2 )
    end

    it "should find primary sponsorships" do
      expect(Sponsorship.primary).to eq(Sponsorship.where( "seq = 1" ))
    end
  end

  describe "secondary named scope" do
    before(:each) do
      FactoryGirl.create( :sponsorship, :seq => 1 )
      FactoryGirl.create( :sponsorship, :seq => 2 )
    end

    it "should find primary sponsorships" do
      expect(Sponsorship.secondary).to eq(Sponsorship.where( "seq != 1" ))
    end
  end

  describe "methods provided by Member model" do
    before( :each ) do |variable|
      @member = FactoryGirl.create( :member )
      @sponsorship = FactoryGirl.create( :sponsorship, :member => @member )
    end

    it "should provide name" do
      expect(@sponsorship.name).to eq(@member.name)
    end

    it "should provide display_name" do
      expect(@sponsorship.display_name).to eq(@member.display_name)
    end

    it "should provide first_name" do
      expect(@sponsorship.first_name).to eq(@member.first_name)
    end

    it "should provide last_name" do
      expect(@sponsorship.last_name).to eq(@member.last_name)
    end

    it "should provide district_name" do
      expect(@sponsorship.district_name).to eq(@member.district_name)
    end
  end
end
