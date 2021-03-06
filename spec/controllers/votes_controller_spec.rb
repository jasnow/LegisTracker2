require 'spec_helper'

describe VotesController, :type => :controller do
  before( :each ) do
    @user = FactoryBot.create( :user )
    sign_in @user
  end

  describe VotesController, '#show' do
    before( :each ) do
      @bill = FactoryBot.create( :bill )
      @vote = FactoryBot.create( :vote, :bill => @bill )
      get :show, :id => @vote.id
    end
    it { is_expected.to respond_with( :success ) }
    it { expect(assigns(:vote )).to eq(@vote) }
    it { expect(assigns(:title)).to eq(
      "#{@vote.legislation}: #{@vote.description}") }
    it { expect(assigns(:bill )).to eq(@vote.bill) }
  end

  describe VotesController, '#key' do
    before( :each ) do
      @vote = FactoryBot.create( :vote )
      get :key, :id => @vote.id
    end
    it { is_expected.to respond_with( :redirect ) }
    it { expect(assigns( :vote )).to eq(@vote) }
    it { is_expected.to set_flash.to( "Successfully tagged as key vote" ) }
  end

  describe VotesController, '#unkey' do
    before( :each ) do
      @vote = FactoryBot.create( :vote )
      @vote.key_list.add( 'key' )
      @vote.save
      get :unkey, :id => @vote.id
    end
    it { is_expected.to respond_with( :redirect ) }
    it { expect(assigns(:vote)).to eq(@vote) }
    it { is_expected.to set_flash.to( "Successfully removed tag as key vote" ) }
  end
end
