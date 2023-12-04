require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HoangHoaIVEducation
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    def version
      return 'dev' unless Rails.env.production?

      release_version = Rails.root.join('app_version').read.strip
      if ENV['HEROKU_APP_NAME']&.include? 'production'
        release_version
      elsif ENV['HEROKU_REVIEW_APP'] == 'true'
        ENV.fetch('HEROKU_BRANCH', nil)
      else
        ENV['HEROKU_SLUG_COMMIT']&.first(8) || release_version
      end
    end
  end
end
