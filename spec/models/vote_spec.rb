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
    vote.save.should be true
    Vote.count.should == previous_record_count + 1
  end

  it "should have correct bill id" do
    vote = @bill.votes.new( FactoryGirl.attributes_for( :vote ) )
    vote.save.should be true
    vote.bill_id.should == @bill.id
  end

  it "should provide most recent" do
    last_date = Vote.last_date
    vote = Vote.most_recent.first
    vote.date.to_s.should match( /2011-01-10/ )
  end

  describe "last_date method" do
    before( :each ) do
      FactoryGirl.create( :vote, :bill => @bill, :date => '2011-01-05 12:00:00' )
    end

    it "should match find max date result" do
      Vote.maximum( "DATE(date)" ).should == Vote.last_date
    end

    it "should not match older dates" do
      Vote.last_date.should_not be < ( '2011-01-10' )
    end
  end

  describe "most_recent method" do
    before( :each ) do
      FactoryGirl.create( :vote, :bill => @bill, :date => '2011-01-05 12:00:00' )
    end

    it "should include all statuses on most recent date" do
      FactoryGirl.create( :vote, :bill=> @bill, :date => '2011-01-10 15:00:00')
      Vote.where( "DATE(date) = ?", Vote.last_date ).should == Vote.most_recent
    end

    it "should not include statuses from older dates" do
      Vote.most_recent.each do |recent|
        Vote.where( "DATE(date) != ?", Vote.last_date ).each do |old|
          recent.should_not == old
        end
      end
    end
  end

  describe "find_for_date" do
    before( :each ) do
      FactoryGirl.create( :vote, :bill => @bill, :date => '2011-01-05 12:00:00' )
      FactoryGirl.create( :vote, :bill => @bill, :date => '2011-01-05 12:00:00' )
      FactoryGirl.create( :vote, :bill => @bill, :date => '2011-01-06 12:00:00' )
    end

    it "should find all votes on a given date" do
      Vote.where( "DATE(date) = ?", '2011-01-05' ).should == Vote.find_for_date( '2011-01-05')
    end

    it "should not find dates on on the given date" do
      Vote.find_for_date( '2011-01-10' ).each do |on_date|
        Vote.where( "DATE(date) != ?", '2011-01-10' ).each do |not_on_date|
          on_date.should_not == not_on_date
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
      @vote.save.should == true
    end

    it "should find votes tagged as key" do
      key_vote = FactoryGirl.create( :vote )
      key_vote.key_list.add( 'key' )
      key_vote.save

      Vote.key.all.should == Vote.tagged_with( 'key' )
      Vote.key.count.should == 1
      Vote.key.first.should == key_vote
    end

    it "should return true if is key vote" do
      @vote.key_list.add( 'key' )
      @vote.save

      @vote.is_key?.should == true
    end
  end

  describe "votes on hot bills" do
    before( :each ) do
      @hot_bill = FactoryGirl.create( :bill )
      @hot_bill.hot_list.add( 'hot' )
      @hot_bill.save
      @hot_vote = FactoryGirl.create( :vote, :bill => @hot_bill )

      @cold_bill = FactoryGirl.create( :bill, :num => 2, :number => 'HB2' )
      @cold_vote = FactoryGirl.create( :vote, :bill => @cold_bill, :legislation => 'HB 2' )
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
