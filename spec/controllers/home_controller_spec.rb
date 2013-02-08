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
    it { should assign_to( :title ).with( 'Home' ) }

    it "should route '/' to home/index" do
      { :get => "/" }.should route_to( :controller => "home", :action => "index" )
    end

    it "should route root_path to home/index" do
      { :get => root_path }.should route_to( :controller => "home", :action => "index" )
    end

    describe "Show watched bill events" do
      it { should assign_to( :bills ).with( @user.watched_bills.order_by_status_date_desc ) }
      it { should assign_to( :votes  ).with( @user.watched_bill_votes ) }
    end

    describe "Show recent press releases" do
      it { should assign_to( :house_rss  ).with( HouseFeed.find_recent  ) }
      it { should assign_to( :senate_rss ).with( SenateFeed.find_recent ) }
    end
  end
end
######################################################################
