class StatusCode < ActiveRecord::Base
  self.primary_key = 'id'
  has_many :statuses
end
