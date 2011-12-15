require "active_record"
require "settings"
require "settings/version"

unless ::Rails.version < "3.1"
  require "persistent_settings/rails/engine"
  require "generators/persistent_settings/migration_generator"
end
