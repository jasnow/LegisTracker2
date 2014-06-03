require 'spec_helper'

describe Bill, :type => :model do
  before( :each ) do
    @attr = FactoryGirl.attributes_for( :bill )
  end

  it { is_expected.to have_many( :statuses ) }
  it { is_expected.to have_many( :votes ) }
  it { is_expected.to have_many( :bill_versions ) }
  it { is_expected.to have_many( :sponsorships ) }
  it { is_expected.to have_many( :members ).through( :sponsorships ) }
  it { is_expected.to belong_to( :house_committee ) }
  it { is_expected.to belong_to( :senate_committee ) }

  it "should create new bill record" do
    previous_record_count = Bill.count
    bill = Bill.new( @attr )
    expect(bill.save).to be true
    expect(Bill.count).to eq(previous_record_count + 1)
  end

  describe "taggable as hot bill" do
    before( :each ) do
      @bill = FactoryGirl.create( :bill )
    end

    it "should take tag 'hot'" do
      bill = FactoryGirl.create( :bill )
      bill.hot_list.add( 'hot' )
      expect(bill.save).to be true
    end

    it "should find bills tagged as hot" do
      hot_bill = FactoryGirl.create( :bill )
      hot_bill.hot_list.add( 'hot' )
      hot_bill.save

      expect(Bill.hot.all).to eq(Bill.tagged_with( 'hot' ))
      expect(Bill.hot.count).to eq(1)
      expect(Bill.hot.first).to eq(hot_bill)
    end

    it "should return true from is_hot? if hot" do
      @bill.hot_list = 'hot'
      expect(@bill.is_hot?).to eq(true)
    end

    it "should return false from is_hot? if not hot" do
      expect(@bill.is_hot?).to eq(false)
    end
  end

  describe "topic tags" do
    before( :each ) do
      @bill = FactoryGirl.create( :bill )
    end

    it "should take topic tag" do
      @bill.topic_list.add( 'taxes' )
      expect(@bill.save).to be true
    end

    it "should find bills by topic tag" do
      @bill.topic_list.add( 'taxes' )
      @bill.save
      expect(Bill.topic_includes( 'taxes' ).all).to eq(Bill.tagged_with(
        'taxes', :on => :topics ))
    end
  end

  describe "versions" do
    before( :each ) do
      @bill = FactoryGirl.create( :bill )
      @first_version = FactoryGirl.create( :bill_version, :bill => @bill )
    end

    it "should find latest version" do
      newer_version = FactoryGirl.create( :bill_version,
                                      :bill => @bill,
                                      :number => @first_version.number + 1 )

      expect(@bill.latest_version).to eq(newer_version)
    end
  end

  describe "ccrossover" do
    before( :each ) do
      @not_yet_bill = FactoryGirl.create( :bill )
      @crossed_over_bill = FactoryGirl.create( :bill,
                                           :num            => "2",
                                           :number         => "HB 2",
                                           :status_code_id => 'HPA',
                                           :crossover      => 1
      )
    end

    it "should find crossed over bills" do
      expect(Bill.crossed_over.all).to eq(Bill.where( "crossover = 1" ))
    end

    it "should be true if crossed over" do
      expect(@crossed_over_bill.crossover).to eq(true)
    end

    it "should be false if not crossed over" do
      expect(@not_yet_bill.crossover).to eq(false)
    end
  end
end
