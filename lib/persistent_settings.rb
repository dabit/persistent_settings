require "rails/version"
require "rails/engine"
require "active_record"
require "persistent_settings/version"
require "settings"

unless Rails::VERSION::STRING < "3.1"
  require "persistent_settings/rails/engine"
  require "generators/persistent_settings/migration_generator"
end
