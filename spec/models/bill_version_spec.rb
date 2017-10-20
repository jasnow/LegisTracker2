require 'spec_helper'

describe BillVersion, :type => :model do
  before( :each ) do
    @version = FactoryBot.create( :bill_version )
  end
  it { is_expected.to belong_to( :bill ) }

  it "should return version url" do
    expect(@version.url).to eq("http://www1.legis.ga.gov/legis/" +
      "2011_12/versions/#{@version.fileid}")
  end

  describe "ordered by number" do
    before( :each ) do
      @newer_version = FactoryBot.create( :bill_version,
        :number => @version.number + 1 )
    end

    it "should order by number decsending" do
      top_search_result = BillVersion.order_desc.first
      expect(top_search_result.number).to eq(@newer_version.number)
    end

    it "should return latest version" do
      expect(BillVersion.latest).to eq(@newer_version)
    end
  end
end
