source 'https://rubygems.org'

ruby "2.3.1"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bcrypt', '~> 3.1', '>= 3.1.11'
gem "pry"
gem 'unicorn'
gem 'carrierwave', '~> 0.11.2'
gem 'fog-aws'
gem 'mini_magick', '~> 4.5', '>= 4.5.1'
gem "faker"
gem 'jquery-ui-rails'
gem "will_paginate-bootstrap"

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'htmlbeautifier'
  gem "better_errors"
  gem "meta_request"
  gem "binding_of_caller"
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
