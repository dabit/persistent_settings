require 'persistent_settings'
require 'logger'

ActiveRecord::Migration.verbose = false
ActiveRecord::Base.logger = Logger.new("test.log")
::ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

Dir["./spec/support/**/*.rb"].each {|f| require f}

::ActiveRecord::Schema.define(:version => 1) do
  create_table "configs", :force => true do |t|
    t.string "var"
    t.string "value"
  end
end

#class Settings < ActiveRecord::Base
  #include Persistent::Settings
#end
