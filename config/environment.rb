# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!
Rails.application.configure do
...
# returns error saying to add "rails_example" to config.hosts
config.hosts << "ec2-54-80-44-224.compute-1.amazonaws.com"
...
end
