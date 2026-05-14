# frozen_string_literal: true

source 'https://rubygems.org'

ruby file: '.ruby-version'

gem 'bootsnap', require: false
gem 'puma', '>= 6.0'
gem 'rack-cors', '>= 2.0'
gem 'rails', '~> 8.1.3'
gem 'sqlite3', '>= 2.1'

group :development, :test do
  gem 'brakeman', require: false
  gem 'debug', platforms: %i[mri windows], require: 'debug/prelude'
  gem 'dotenv-rails', '>= 3.1'
  gem 'rubocop-rails', require: false
end
