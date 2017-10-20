require 'spec_helper'

describe Status, :type => :model do
  before(:each) do
    @bill = FactoryBot.create( :bill )
    FactoryBot.create( :status, :bill => @bill )
  end

  it { is_expected.to belong_to(:bill) }
  it { is_expected.to belong_to(:status_code) }

  it "should create new status record" do
    previous_record_count = Status.count
    status = @bill.statuses.new( FactoryBot.attributes_for( :status ) )
    expect(status.save).to be true
    expect(Status.count).to eq(previous_record_count + 1)
  end

  it "should have correct bill id" do
    status = @bill.statuses.new( FactoryBot.attributes_for( :status ) )
    expect(status.save).to be true
    expect(status.bill_id).to eq(@bill.id)
  end

  it "should provide most recent status events" do
    status = Status.most_recent.first
    expect(status.status_date.to_s).to match( /2011-01-10/ )
  end

  describe "last_date method" do
    before( :each ) do
      FactoryBot.create( :status, :bill => @bill,
        :status_date => '2011-01-05 12:00:00' )
    end

    it "should match find max date result" do
      expect(Status.maximum( "DATE(status_date)" )).to eq(Status.last_date)
    end

    it "should not match older dates" do
      expect(Status.last_date).not_to be < '2011-01-10'
    end
  end

  describe "most_recent method" do
    before( :each ) do
      FactoryBot.create( :status, :bill => @bill,
        :status_date => '2011-01-10 12:00:00' )
      FactoryBot.create( :status, :bill => @bill,
        :status_date => '2011-01-05 12:00:00' )
    end

    it "should include all statuses on most recent date" do
      FactoryBot.create( :status, :bill=> @bill,
        :status_date => '2011-01-10 15:00:00')
      expect(Status.where( "DATE(status_date) = ?",
        Status.last_date )).to eq(Status.most_recent)
    end

    it "should not include statuses from older dates" do
      Status.most_recent.each do |recent|
        Status.where( "DATE(status_date) != ?", Status.last_date
          ).each do |old|
          expect(recent).not_to eq(old)
        end
      end
    end
  end

  describe "find_for_date method" do
    before( :each ) do
      FactoryBot.create( :status, :bill => @bill,
        :status_date => '2011-01-05 12:00:00' )
      FactoryBot.create( :status, :bill => @bill,
        :status_date => '2011-01-06 12:00:00' )
      FactoryBot.create( :status, :bill => @bill,
        :status_date => '2011-01-07 13:00:00' )
    end

    it "should find find all statuses for a given date" do
      FactoryBot.create( :status, :bill => @bill,
        :status_date => '2011-01-05 13:00:00' )
      expect(Status.where( "DATE(status_date) = ?", '2011-01-05'
        )).to eq(Status.find_for_date( '2011-01-05' ))
    end

    it "should not find find any statuses not on a given date" do
      Status.find_for_date( '2011-01-10' ).each do |on_date|
        Status.where( "DATE(status_date) != ?", '2011-01-10'
          ).each do |not_on_date|
          expect(on_date).not_to eq(not_on_date)
        end
      end
    end
  end
end
