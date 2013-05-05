require 'spec_helper'

describe StatusesController do
  before( :each ) do
    @user = FactoryGirl.create( :user )
    sign_in @user
  end
  before( :each ) do
    @bill = FactoryGirl.create( :bill )
    @status = FactoryGirl.create( :status, :bill => @bill )
    @votes = FactoryGirl.create( :vote, :bill => @bill )
    get :index
  end

  describe StatusesController, "#index" do
    it { should respond_with( :success ) }
    it { should render_template( :index ) }
    it { assigns(:title      ).should eq('Daily bill status report') }
    it { assigns(:status_date).should eq(Status.last_date) }
    it { assigns(:events     ).should eq(Status.find_for_date(Status.last_date)) }
    it { assigns(:vote_date  ).should eq(Vote.last_date.to_s) }
    it { assigns(:votes      ).should eq(Vote.find_for_date(Vote.last_date.to_s)) }
  end
end
