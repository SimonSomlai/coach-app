# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

environment_variables = File.join(Rails.root, 'config', 'initializers', 'environment_variables.rb')
load(environment_variables) if File.exists?(environment_variables) 
