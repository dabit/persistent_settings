require 'spec_helper'

describe PersistentSettings::CreateGenerator do
  let(:destination) { 'tmp'}

  let(:model_path) do
    File.join(destination, 'models', 'module/config.rb')
  end

  let(:migration_path) do
    File.join(destination, 'db', 'migrate', 'YYYYMMDDHHMM_create_module_configs_table.rb')
  end

  before do
    File.unlink(model_path) if File.exists?(model_path)
    File.unlink(migration_path) if File.exists?(migration_path)
    PersistentSettings::CreateGenerator.stub(:next_migration_number).
        and_return('YYYYMMDDHHMM')
    PersistentSettings::CreateGenerator.start(['module/config', 0], :destination_root => destination)
  end

  it "creates the model file" do
    File.exists?(model_path).should be_true
    File.read(model_path).should match /Module::Config/
  end

  it "creates the migration file" do
    File.exists?(migration_path).should be_true
    file = File.read(migration_path)
    file.should match /CreateModuleConfigs/
    file.should match /create_table :module_configs/
  end
end
