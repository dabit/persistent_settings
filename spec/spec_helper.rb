require 'persistent_settings'

::ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

::ActiveRecord::Schema.define(:version => 1) do
  create_table "settings", :force => true do |t|
    t.string "var"
    t.string "value"
  end
end
