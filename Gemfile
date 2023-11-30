# frozen_string_literal: true

# rubocop:disable Bundler/OrderedGems

source 'https://rubygems.org'
ruby File.read('.ruby-version').strip

gem 'bootsnap', '>= 1.4.2', require: false
gem 'jsbundling-rails'
gem 'pg', '>= 0.18', '< 2.0'

gem 'puma', '~> 6.3'
gem 'rails', '~> 7.0'
gem 'sass-rails', '>= 6'
gem 'sprockets-rails'
gem 'stimulus-rails', '~> 1.2'
gem 'turbo-rails', '~> 1.5'

gem 'rails-i18n', '~> 7.0.6'      # Internationalization for Rails

gem 'business_time'               # Business days between dates
gem 'ibandit'                     # Validate IBAN bank account numbers
gem 'jsonpath'                    # XPath-like query for json
gem 'local_time'                  # Display times in local browser time
gem 'pagy'                        # Pagination
gem 'paper_trail', '~> 14.0'      # Versioning
gem 'paper_trail-association_tracking', '~> 2.2.1'
gem 'premailer-rails'             # Inline CSS in emails
gem 'view_component'              # View components

gem 'liquid', '~> 5.4' # Email template

gem 'grover'
gem 'pdf-inspector', '~> 1.3'     # PDF inspection
gem 'prawn'                       # PDFs
gem 'prawn-svg'                   # PDF SVGs
gem 'prawn-table'                 # PDF tables

gem 'invisible_captcha'           # Captcha

gem 'activerecord-session_store'  # Database as session store (default was cookie)
gem 'devise'                      # Authentication
gem 'devise-i18n'                 # Authentication translations for many languages
gem 'pundit', '~> 2.3'            # Authorization

gem 'noticed', '~> 1.6'           # Notifications for your Ruby on Rails app

gem 'ahoy_matey'                  # First party analytics
gem 'device_detector', '1.0.5'    # Pinning to resolve warnings

gem 'geocoder'                    # Geocoding
gem 'iso_country_codes'           # Provides ISO codes, names and currencies for countries.
gem 'pg_search'                   # Full-text search

gem 'aws-sdk-s3', require: false  # ActiveStorage
gem 'barnes'                      # Metrics for Heroku Dashboard
gem 'easymon'                     # Healthcheck endpoint
gem 'faker'                       # Fake data generating
gem 'image_processing'            # ActiveStorage: Image Resizing
gem 'mini_magick'                 # ActiveStorage: Image Resizing
gem 'rollbar', '3.4.0'            # Exception Service
gem 'sidekiq'                     # Background job processing

gem 'maintenance_job'             # Run testable one off jobs on the database, https://github.com/ayushn21/maintenance_job
gem 'rails-patterns'              # lightweight, standardized, rails-oriented patterns

gem 'net-http'                    # Remove when upstream deprecation is fixed
# gem 'flipper'
# gem 'flipper-active_record'
# gem 'flipper-ui'
gem 'array_enum'
gem 'jsonb_accessor'

gem 'caxlsx'                      # Axlsx is an Office Open XML Spreadsheet generator
gem 'caxlsx_rails'                # Axlsx-Rails adds the :xlsx format and parses .xlsx.axlsx templates
gem 'roo'                         # Roo implements read access for all common spreadsheet types
gem 'put'                         #  to provide a more expressive, fault-tolerant, and configurable approach to sorting Ruby objects with multiple criteria.

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'i18n-debug'
  gem 'mock_redis'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
end

group :development do
  gem 'awesome_print'
  gem 'letter_opener_web'
  gem 'listen', '~> 3.7'
  gem 'memory_profiler'
  gem 'rack-mini-profiler'
  gem 'rails-erd'
  gem 'saga'
  gem 'simplecov', require: false
  gem 'simplecov_json_formatter', require: false
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'magic_test'
  gem 'minitest-reporters', require: false
  gem 'mocha'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'webmock'
end

# rubocop:enable Bundler/OrderedGems
