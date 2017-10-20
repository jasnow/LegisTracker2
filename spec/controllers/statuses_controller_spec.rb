require 'spec_helper'

describe StatusesController, :type => :controller do
  before( :each ) do
    @user = FactoryBot.create( :user )
    sign_in @user
  end
  before( :each ) do
    @bill = FactoryBot.create( :bill )
    @status = FactoryBot.create( :status, :bill => @bill )
    @votes = FactoryBot.create( :vote, :bill => @bill )
    get :index
  end

  describe StatusesController, "#index" do
    it { is_expected.to respond_with( :success ) }
    it { is_expected.to render_template( :index ) }
    it { expect(assigns(:title      )).to eq('Daily bill status report') }
    it { expect(assigns(:status_date)).to eq(Status.last_date) }
    it { expect(assigns(:events     )).to eq(Status.find_for_date(
      Status.last_date)) }
    it { expect(assigns(:vote_date  )).to eq(Vote.last_date.to_s) }
    it { expect(assigns(:votes      )).to eq(Vote.find_for_date(
      Vote.last_date.to_s)) }
  end
end
