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
    it { expect(assigns(:title      )).to eq('Daily bill status report') }
    it { expect(assigns(:status_date)).to eq(Status.last_date) }
    it { expect(assigns(:events     )).to eq(Status.find_for_date(
      Status.last_date)) }
    it { expect(assigns(:vote_date  )).to eq(Vote.last_date.to_s) }
    it { expect(assigns(:votes      )).to eq(Vote.find_for_date(
      Vote.last_date.to_s)) }
  end
end
