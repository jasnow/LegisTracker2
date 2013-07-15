require 'spec_helper'

describe BillsController do
  before( :each ) do
    @user = FactoryGirl.create( :user )
    sign_in @user
  end

  describe BillsController, '#index' do
    before( :each ) do
      get :index
    end
    it { should respond_with( :success ) }
    it { should render_template( :index ) }
    it { assigns( :title ).should eq("Search results") }
    it { assigns( :bills ).should be_true  }
    it "should route '/bills' to bills/index" do
      { :get => bills_path }.should route_to( :controller => "bills",
        :action => "index" )
    end
  end

  describe BillsController, '#show' do
    before( :each ) do
      @bill = FactoryGirl.create( :bill )
      get :show, :id => @bill.id
    end
    it { should respond_with( :success ) }
    it { should render_template( :show ) }
    it { assigns(:bill ).should eq(@bill) }
    it { assigns(:title).should eq(@bill.number) }
    it "should route bill_path to bills/should" do
      { :get => bill_path }.should route_to( :controller => "bills",
        :action => "show", :id => @bill.to_param )
    end
  end

  describe BillsController, '#search' do
    before( :each ) do
      get :search
    end
    it { should respond_with( :success ) }
    it { should render_template( :search ) }
    it { assigns(:title).should eq("Advanced Search") }
    it "should route search_path to bills/search" do
      { :get => search_path }.should route_to( :controller => "bills",
        :action => "search" )
    end
  end

  describe BillsController, '#hot' do
    pending do
      before( :each ) do
        @bill = FactoryGirl.create( :bill )
        get :hot, :id => @bill.id
      end

      it { should respond_with(:redirect) }
      it { should set_the_flash.to(
        "Bill successfully added to the watch list" ) }

      it "should route hot_bill_path to bills/hot" do
        { :get => hot_bill_path }.should route_to( :controller => "bills",
          :action => "hot", :id => @bill.to_param )
      end
    end
  end

  describe BillsController, '#unhot' do
    pending do
     before( :each ) do
        @bill = FactoryGirl.create( :bill )
        @watched_bill = @bill.watched_bills.new( :user_id => @user.id )
        @watched_bill.save
        get :unhot, :id => @bill.id
      end

      it { should respond_with( :redirect ) }
      it { should set_the_flash.to(
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
    it { should respond_with( :redirect ) }
    it { should set_the_flash.to(/Bill successfully tagged with topic/) }
    it { assigns(:bill).should eq(@bill) }
    it "should include 'taxes' tag in topics_list" do
      @bill.topic_list.should include( 'taxes' )
    end
  end
end
