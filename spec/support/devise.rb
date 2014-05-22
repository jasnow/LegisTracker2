RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller

#RSPEC 3.0
#  config.mock_with :rspec do |c|
#    c.yield_receiver_to_any_instance_implementation_blocks = true
#  end
end
