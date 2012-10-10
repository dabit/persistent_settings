require "rails/version"
require "rails/engine"
require "active_record"
require "persistent_settings/version"

require "persistent_settings/rails/engine"
require "generators/persistent_settings/create_generator"

module Persistent
  autoload :Settings, 'persistent/settings'
  module Settings
    autoload :Caching, 'persistent/settings/caching'
    autoload :Persistance, 'persistent/settings/persistance'
  end
end

module PersistentSettings ; end
