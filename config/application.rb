# frozen_string_literal: true
require_relative 'boot'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CoachApp
  class Application < Rails::Application

  end
end
