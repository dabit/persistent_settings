require 'active_record'
require 'persistent_settings'

puts ::ActiveRecord::Base.connected?

::ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
::ActiveRecord::Schema.define(:version => 1) do
  create_table :movies do |t|
    t.column :name, :string
  end
end
puts ::ActiveRecord::Base.connected?
