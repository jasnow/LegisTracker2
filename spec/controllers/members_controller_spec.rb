require 'spec_helper'

describe MembersController do
  before( :each ) do
    @user = FactoryGirl.create( :user )
    sign_in @user
  end

  describe MembersController, '#index' do
    before( :each ) do
      get :index
    end
    it { should respond_with( :success ) }
    it { assigns( :title ).should eq( "Members") }
    it "should route members_path to members/index" do
      { :get => members_path }.should route_to( :controller => "members", :action => "index" )
    end
  end

  describe MembersController, '#show' do
    before( :each ) do
      @member = FactoryGirl.create( :member )
      get :show, :id => @member.id
    end
    it { should respond_with( :success ) }
    it { assigns(:title ).should eq(@member.name) }
    it { assigns(:member).should eq(@member) }
    it "should route member_path to members/show" do
      { :get => member_path }.should route_to( :controller => "members", :action => "show", :id => @member.to_param )
    end
  end
end
