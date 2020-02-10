# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.6.4'

gem 'celluloid-io'
gem 'dotenv'
gem 'puma'
gem 'sinatra'
gem 'slack-ruby-bot'

group :development, :test do
  gem 'foreman'
  gem 'pry', '~> 0.12.2'
  gem 'rake'
  gem 'rubocop', require: false
end

group :test do
  gem 'rack-test'
  gem 'rspec'
  gem 'vcr'
  gem 'webmock'
end
