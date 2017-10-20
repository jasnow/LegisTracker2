require 'spec_helper'

describe MembersController, :type => :controller do
  before( :each ) do
    @user = FactoryBot.create( :user )
    sign_in @user
  end

  describe MembersController, '#index' do
    before( :each ) do
      get :index
    end
    it { is_expected.to respond_with( :success ) }
    it { expect(assigns( :title )).to eq( "Members") }
    it "should route members_path to members/index" do
      expect({ :get => members_path }).to route_to( :controller => "members",
        :action => "index" )
    end
  end

  describe MembersController, '#show' do
    before( :each ) do
      @member = FactoryBot.create( :member )
      get :show, :id => @member.id
    end
    it { is_expected.to respond_with( :success ) }
    it { expect(assigns(:title )).to eq(@member.name) }
    it { expect(assigns(:member)).to eq(@member) }
    it "should route member_path to members/show" do
      expect({ :get => member_path }).to route_to( :controller => "members",
        :action => "show", :id => @member.to_param )
    end
  end
end
