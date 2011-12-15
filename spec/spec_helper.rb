require 'rails'
require 'active_record'
require 'persistent_settings'

::ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

