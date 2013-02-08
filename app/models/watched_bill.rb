class WatchedBill < ActiveRecord::Base

  attr_accessible :user, :bill

  belongs_to :user
  belongs_to :bill
end
