require 'rails/generators'
require 'rails/generators/migration'

module PersistentSettings
  class MigrationGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    source_root File.expand_path('../templates', __FILE__)

    def install
      migration_template "create_settings_table.rb", "db/migrate/create_settings_table.rb"
    end

    def self.next_migration_number(path)
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    end
  end
end
