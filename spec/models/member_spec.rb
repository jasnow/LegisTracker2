require 'spec_helper'

describe Member do
  it { should have_many( :sponsorships ) }
  it { should have_many( :bills ).through( :sponsorships ) }

  describe "information formatted for display" do
    before( :each ) do
      @member = FactoryGirl.create( :member )
    end

    it "should return last_name, first_name as name" do
      expect(@member.name).to eq("#{@member.last_name}, #{@member.first_name}")
    end

    it "should return first_name last_name as display_name" do
      expect(@member.display_name).to eq("#{@member.first_name} " +
        "#{@member.last_name}")
    end

    it "should return house and district as district_name" do
      expect(@member.district_name).to eq("#{@member.house}#{@member.district}")
    end
  end

  describe "party search scopes" do
    before( :each ) do
      FactoryGirl.build( :member, :party => 'D' )
      FactoryGirl.build( :member, :party => 'R' )
    end

    it "should return only democratic members" do
      expect(Member.democrats.all).to eq(Member.where( "party = ?", 'D' ))
    end

    it "should return only republican members" do
      expect(Member.republicans.all).to eq(Member.where( "party = ?", 'R' ))
    end

    it "should find members of a party" do
      expect(Member.find_by_party('D').all).to eq(
        Member.where( "party = ?", 'D' ))
      expect(Member.find_by_party('R').all).to eq(
        Member.where( "party = ?", 'R' ))
    end
  end

  describe "house search scopes" do
    before( :each ) do
      FactoryGirl.build( :member, :house => 'H' )
      FactoryGirl.build( :member, :house => 'S' )
    end

    it "should find only house members" do
      expect(Member.reps.all).to eq(Member.where( "house = ?", 'H' ))
    end

    it "should find only senate members" do
      expect(Member.senators.all).to eq(Member.where( "house = ?", 'S' ))
    end

    it "should find members of a house" do
      expect(Member.find_by_house( 'H' ).all).to eq(
        Member.where( "house = ?", 'H' ))
      expect(Member.find_by_house( 'S' ).all).to eq(
        Member.where( "house = ?", 'S' ))
    end
  end
end
