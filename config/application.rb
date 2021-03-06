require File.expand_path('../boot', __FILE__)

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
# require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'
require 'rack/rewrite'
# require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

require 'parliament/engine'
require 'pugin'
require 'parliament/utils'

module MembersPrototype
  class Application < Rails::Application
    # Rewrite trailing slashes
    config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
      r301 %r{^/(.*)/$}, '/$1'
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

    # Add our custom validators to our autoload paths
    config.autoload_paths += %W["#{config.root}/app/validators/"]

    # Add our custom serializers to our autoload paths
    config.autoload_paths += %W["#{config.root}/app/serializers/"]

    config.action_view.field_error_proc = Proc.new { |html_tag, instance|
      html_tag
    }

    # Allow table HTML tags as sanitized
    config.after_initialize do
      ActionView::Base.sanitized_allowed_tags += %w(table thead tbody tfoot tr th td)
    end
  end
end
