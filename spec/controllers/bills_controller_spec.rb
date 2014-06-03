require 'spec_helper'

describe BillsController, :type => :controller do
  before( :each ) do
    @user = FactoryGirl.create( :user )
    sign_in @user
  end

  describe BillsController, '#index' do
    before( :each ) do
      get :index
    end
    it { is_expected.to respond_with( :success ) }
    it { is_expected.to render_template( :index ) }
    it { expect(assigns( :title )).to eq("Search results") }
    it { expect(assigns( :bills )).to be_truthy }
    it "should route '/bills' to bills/index" do
      expect({ :get => bills_path }).to route_to( :controller => "bills",
        :action => "index" )
    end
  end

  describe BillsController, '#show' do
    before( :each ) do
      @bill = FactoryGirl.create( :bill )
      get :show, :id => @bill.id
    end
    it { is_expected.to respond_with( :success ) }
    it { is_expected.to render_template( :show ) }
    it { expect(assigns(:bill )).to eq(@bill) }
    it { expect(assigns(:title)).to eq(@bill.number) }
    it "should route bill_path to bills/should" do
      expect({ :get => bill_path }).to route_to( :controller => "bills",
        :action => "show", :id => @bill.to_param )
    end
  end

  describe BillsController, '#search' do
    before( :each ) do
      get :search
    end
    it { is_expected.to respond_with( :success ) }
    it { is_expected.to render_template( :search ) }
    it { expect(assigns(:title)).to eq("Advanced Search") }
    it "should route search_path to bills/search" do
      expect({ :get => search_path }).to route_to( :controller => "bills",
        :action => "search" )
    end
  end

  describe BillsController, '#hot' do
    skip do
      before( :each ) do
        @bill = FactoryGirl.create( :bill )
        get :hot, :id => @bill.id
      end

      it { is_expected.to respond_with(:redirect) }
      it { is_expected.to set_the_flash.to(
        "Bill successfully added to the watch list" ) }

      it "should route hot_bill_path to bills/hot" do
        { :get => hot_bill_path }.should route_to( :controller => "bills",
          :action => "hot", :id => @bill.to_param )
      end
    end
  end

  describe BillsController, '#unhot' do
    skip do
     before( :each ) do
        @bill = FactoryGirl.create( :bill )
        @watched_bill = @bill.watched_bills.new( :user_id => @user.id )
        @watched_bill.save
        get :unhot, :id => @bill.id
      end

      it { is_expected.to respond_with( :redirect ) }
      it { is_expected.to set_the_flash.to(
        "Bill successfully removed to watch list" ) }
      it { assigns(:bill).should eq(@bill) }

      it "should route unhot_bill_path to bills/unhot" do
        { :get => unhot_bill_path }.should route_to( :controller => "bills",
          :action => "unhot", :id => @bill.to_param )
      end
    end
  end

  describe BillsController, '#add_tag' do
    before( :each ) do
      @bill = FactoryGirl.create( :bill )
      get :add_tag, :id => @bill.id, :context => 'topics', :tag => 'taxes'
    end
    it { is_expected.to respond_with( :redirect ) }
    it { is_expected.to set_the_flash.to(/Bill successfully tagged with topic/) }
    it { expect(assigns(:bill)).to eq(@bill) }
    it "should include 'taxes' tag in topics_list" do
      expect(@bill.topic_list).to include( 'taxes' )
    end
  end
end
