require File.expand_path('../boot', __FILE__)

# Uncomment following line to enable active_record
# require 'rails/all'
# Comment following lines to disable mongoid, make sure 'rails/all' is uncommented
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module TrentoCarSharing
  class Application < Rails::Application

    # don't generate RSpec tests for views and helpers
    config.generators do |g|
      
      g.test_framework :rspec, fixture: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      
      
      g.view_specs false
      g.helper_specs false
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.to_prepare do
      Devise::SessionsController.layout proc{ |controller| action_name == 'new' ? "signup"   : "application" }
      Devise::RegistrationsController.layout proc{ |controller| ['new', 'create', 'update'].include?(action_name)  ? "signup"   : "application" }
      Devise::PasswordsController.layout proc{ |controller| ['new', 'create', 'update'].include?(action_name)  ? "signup"   : "application" }
    end
  end
end
