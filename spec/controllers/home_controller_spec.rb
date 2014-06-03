require 'spec_helper'

describe HomeController, :type => :controller do
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
    it { is_expected.to respond_with( :success ) }
    it { is_expected.to render_template :index }
    it { expect(assigns(:title)).to eq('Home') }

    it "should route '/' to home/index" do
      expect({ :get => "/" }).to route_to( :controller => "home",
        :action => "index" )
    end

    it "should route root_path to home/index" do
      expect({ :get => root_path }).to route_to( :controller => "home",
        :action => "index" )
    end

    describe "Show watched bill events" do
      it { expect(assigns(:bills)).to eq(
        @user.watched_bills.order_by_status_date_desc) }
      it { expect(assigns(:votes)).to eq( @user.watched_bill_votes ) }
    end

    describe "Show recent press releases" do
      it { expect(assigns(:house_rss )).to eq(HouseFeed.find_recent ) }
      it { expect(assigns(:senate_rss)).to eq(SenateFeed.find_recent) }
    end
  end
end
