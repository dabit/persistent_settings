require "rails/version"
require "rails/engine"
require "active_record"
require "persistent_settings/version"

unless Rails::VERSION::STRING < "3.1"
  require "persistent_settings/rails/engine"
  require "generators/persistent_settings/migration_generator"
end

module Persistent
  autoload :Settings, 'persistent/settings'
  module Settings
    autoload :Caching, 'persistent/settings/caching'
    autoload :Persistance, 'persistent/settings/persistance'
  end
end

require "settings"
