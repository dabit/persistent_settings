require 'rails/generators'
require 'rails/generators/migration'

module PersistentSettings
  class CreateGenerator < ::Rails::Generators::Base
    include ::Rails::Generators::Migration

    argument :class_name, :type => :string
    argument :verbose, :type => :numeric, :default => 1

    source_root File.expand_path('../templates', __FILE__)

    def create_model
      @klass_name = class_name.classify
      template 'model.rb.erb', "models/#{class_name}.rb", :verbose => (verbose == 1)
    end

    def create_migration
      @table_name = class_name.pluralize.gsub("/", "_")
      @migration_class = @table_name.camelize
      migration_template "create_table.rb.erb", "db/migrate/create_#{@table_name}_table.rb", :verbose => (verbose == 1)
    end

    def self.next_migration_number(path)
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    end
  end
end
