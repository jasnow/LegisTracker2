require 'spec_helper'

describe Vote do
  before(:each) do
    @bill = FactoryGirl.create( :bill )
    FactoryGirl.create( :vote, :bill => @bill )
  end

  it { should belong_to(:bill) }

  it "should create new vote record" do
    previous_record_count = Vote.count
    vote = @bill.votes.new( FactoryGirl.attributes_for( :vote ) )
    expect(vote.save).to be true
    expect(Vote.count).to eq(previous_record_count + 1)
  end

  it "should have correct bill id" do
    vote = @bill.votes.new( FactoryGirl.attributes_for( :vote ) )
    expect(vote.save).to be true
    expect(vote.bill_id).to eq(@bill.id)
  end

  it "should provide most recent" do
    last_date = Vote.last_date
    vote = Vote.most_recent.first
    expect(vote.date.to_s).to match( /2011-01-10/ )
  end

  describe "last_date method" do
    before( :each ) do
      FactoryGirl.create( :vote, :bill => @bill,
        :date => '2011-01-05 12:00:00' )
    end

    it "should match find max date result" do
      expect(Vote.maximum( "DATE(date)" )).to eq(Vote.last_date)
    end

    it "should not match older dates" do
      expect(Vote.last_date).not_to be < ( '2011-01-10' )
    end
  end

  describe "most_recent method" do
    before( :each ) do
      FactoryGirl.create( :vote, :bill => @bill,
        :date => '2011-01-05 12:00:00' )
    end

    it "should include all statuses on most recent date" do
      FactoryGirl.create( :vote, :bill=> @bill,
        :date => '2011-01-10 15:00:00')
      expect(Vote.where( "DATE(date) = ?", Vote.last_date
        )).to eq(Vote.most_recent)
    end

    it "should not include statuses from older dates" do
      Vote.most_recent.each do |recent|
        Vote.where( "DATE(date) != ?", Vote.last_date ).each do |old|
          expect(recent).not_to eq(old)
        end
      end
    end
  end

  describe "find_for_date" do
    before( :each ) do
      FactoryGirl.create( :vote, :bill => @bill,
        :date => '2011-01-05 12:00:00' )
      FactoryGirl.create( :vote, :bill => @bill,
        :date => '2011-01-05 12:00:00' )
      FactoryGirl.create( :vote, :bill => @bill,
        :date => '2011-01-06 12:00:00' )
    end

    it "should find all votes on a given date" do
      expect(Vote.where( "DATE(date) = ?", '2011-01-05'
        )).to eq(Vote.find_for_date( '2011-01-05'))
    end

    it "should not find dates on on the given date" do
      Vote.find_for_date( '2011-01-10' ).each do |on_date|
        Vote.where( "DATE(date) != ?", '2011-01-10'
          ).each do |not_on_date|
          expect(on_date).not_to eq(not_on_date)
        end
      end
    end

  end

  describe "taggable as key vote" do
    before( :each ) do
      @vote = FactoryGirl.create( :vote )
    end

    it "should take tag 'key'" do\
      @vote.key_list.add( 'key' )
      expect(@vote.save).to eq(true)
    end

    it "should find votes tagged as key" do
      key_vote = FactoryGirl.create( :vote )
      key_vote.key_list.add( 'key' )
      key_vote.save

      expect(Vote.key.all).to eq(Vote.tagged_with( 'key' ))
      expect(Vote.key.count).to eq(1)
      expect(Vote.key.first).to eq(key_vote)
    end

    it "should return true if is key vote" do
      @vote.key_list.add( 'key' )
      @vote.save

      expect(@vote.is_key?).to eq(true)
    end
  end

  describe "votes on hot bills" do
    before( :each ) do
      @hot_bill = FactoryGirl.create( :bill )
      @hot_bill.hot_list.add( 'hot' )
      @hot_bill.save
      @hot_vote = FactoryGirl.create( :vote, :bill => @hot_bill )

      @cold_bill = FactoryGirl.create( :bill, :num => 2, :number => 'HB2' )
      @cold_vote = FactoryGirl.create( :vote, :bill => @cold_bill,
        :legislation => 'HB 2' )
    end

    it "should be true that hot bill vote is hot" do
      @hot_vote.is_hot_bill?.should be_true
    end

    it "should be false that cold bill vote is hot" do
      @cold_vote.is_hot_bill?.should be_false
    end

    it "should find hot bills" do
      hot_votes = Vote.hot_bills

      hot_votes.each do |vote|
        vote.is_hot_bill?.should be_true
      end
    end
  end
end
