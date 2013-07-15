require 'spec_helper'

describe VotesController do
  before( :each ) do
    @user = FactoryGirl.create( :user )
    sign_in @user
  end

  describe VotesController, '#show' do
    before( :each ) do
      @bill = FactoryGirl.create( :bill )
      @vote = FactoryGirl.create( :vote, :bill => @bill )
      get :show, :id => @vote.id
    end
    it { should respond_with( :success ) }
    it { assigns(:vote ).should eq(@vote) }
    it { assigns(:title).should eq(
      "#{@vote.legislation}: #{@vote.description}") }
    it { assigns(:bill ).should eq(@vote.bill) }
  end

  describe VotesController, '#key' do
    before( :each ) do
      @vote = FactoryGirl.create( :vote )
      get :key, :id => @vote.id
    end
    it { should respond_with( :redirect ) }
    it { assigns( :vote ).should eq(@vote) }
    it { should set_the_flash.to( "Successfully tagged as key vote" ) }
  end

  describe VotesController, '#unkey' do
    before( :each ) do
      @vote = FactoryGirl.create( :vote )
      @vote.key_list.add( 'key' )
      @vote.save
      get :unkey, :id => @vote.id
    end
    it { should respond_with( :redirect ) }
    it { assigns(:vote).should eq(@vote) }
    it { should set_the_flash.to( "Successfully removed tag as key vote" ) }
  end
end
