require 'persistent_settings'

::ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
::ActiveRecord::Schema.define(:version => 1) do
  create_table :settings do |t|
    t.column :var, :string
    t.column :value, :string
  end
end
