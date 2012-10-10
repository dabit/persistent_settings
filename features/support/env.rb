require 'rails'
require 'persistent_settings'
require 'logger'

ActiveRecord::Migration.verbose = false
ActiveRecord::Base.logger = Logger.new("test.log")
::ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
::ActiveRecord::Schema.define(:version => 1) do
  create_table :settings do |t|
    t.column :var, :string
    t.column :value, :string
  end
end

module Rails
  RAILS_CACHE = ActiveSupport::Cache::MemoryStore.new
end

class Settings < ActiveRecord::Base
  include Persistent::Settings
end
