require 'spec_helper'

describe HomeController do
  before( :each ) do
    @user = FactoryGirl.create( :user )
    sign_in @user
  end

  describe HomeController, '#index' do
    before( :each ) do
      @bill = FactoryGirl.create( :bill )
      @bill.hot_list.add( 'hot' )
      @bill.save

      @status = FactoryGirl.create( :status, :bill => @bill )
      @votes = FactoryGirl.create( :vote, :bill => @bill )
      @house_feed = FactoryGirl.create( :house_feed )
      @senate_feed = FactoryGirl.create( :senate_feed )
      get :index
    end
    it { should respond_with( :success ) }
    it { should render_template :index }
    it { assigns(:title).should eq('Home') }

    it "should route '/' to home/index" do
      { :get => "/" }.should route_to( :controller => "home",
        :action => "index" )
    end

    it "should route root_path to home/index" do
      { :get => root_path }.should route_to( :controller => "home",
        :action => "index" )
    end

    describe "Show watched bill events" do
      it { assigns(:bills).should eq(
        @user.watched_bills.order_by_status_date_desc) }
      it { assigns(:votes).should eq( @user.watched_bill_votes ) }
    end

    describe "Show recent press releases" do
      it { assigns(:house_rss ).should eq(HouseFeed.find_recent ) }
      it { assigns(:senate_rss).should eq(SenateFeed.find_recent) }
    end
  end
end
