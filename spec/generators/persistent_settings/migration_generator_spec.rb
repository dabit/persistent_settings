require 'spec_helper'

describe PersistentSettings::MigrationGenerator do
  let(:destination) { 'tmp' }
  let(:filename) { File.join(destination, 'db', 'migrate', 'YYYYMMDDHHMM_create_settings_table.rb') }

  before do
    File.unlink(filename) if File.exists?(filename)
    PersistentSettings::MigrationGenerator.stub(:next_migration_number).
        and_return('YYYYMMDDHHMM')
    PersistentSettings::MigrationGenerator.start([], :destination_root => destination)
  end

  it "creates the migration to create the settings table" do
    File.exists?(filename).should be_true
  end
end
