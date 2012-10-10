require 'spec_helper'

describe Settings do
  describe :assignation? do
    context "the method name ends with =" do
      it "returns true" do
        Settings.assignation?("method=").should be_true
      end
    end

    context "the method name does not end with =" do
      it "returns false" do
        Settings.assignation?("method").should be_false
      end
    end
  end

  describe :define_setter_and_getter do
    before do
      Settings.define_setter_and_getter(:method_name=)
    end

    it "creates the setter and getter methods" do
      Settings.should respond_to(:method_name=)
      Settings.should respond_to(:method_name)
    end

    context :getter_method do
      context "value is persisted on cache" do
        before do
          Settings.should_receive(:read_from_cache).with('method_name').
              and_return('value from cache')
        end

        it "reads and returns value from cache" do
          Settings.method_name.should == 'value from cache'
        end
      end

      context "value is not persisted on cache" do
        before do
          Settings.should_receive(:read_from_cache).with('method_name')
        end

        it "reads and returns value from persistance, then saves to cache" do
          Settings.should_receive(:read_from_persistance).with('method_name').
              and_return 'value from persistance'

          Settings.should_receive(:write_to_cache).
              with('method_name', 'value from persistance')

          Settings.method_name.should == 'value from persistance'
        end
      end
    end

    context :setter_method do
      it "persists and writes to cache the key/value" do
        Settings.should_receive(:persist).with('method_name', 'value')
        Settings.should_receive(:write_to_cache).with('method_name', 'value')
        Settings.method_name = 'value'
      end
    end
  end

  describe :persist do
    context "a value already persisted" do
      before :each do
        @setting = mock(Settings)
        Settings.stub_chain(:where, :last).and_return(@setting)
      end

      it "updates the setting" do
        @setting.should_receive(:update_attribute).with(:value, :new_value)
        Settings.persist('some_method', :new_value)
      end
    end

    context "a value that is not persisted" do
      it "creates the setting" do
        Settings.stub_chain(:where, :last).and_return(nil)
        Settings.should_receive(:create).with(:var => 'new_method', :value => 'value')
        Settings.persist('new_method', 'value')
      end
    end
  end

  describe :read_from_persistance do
    it "reads the value from persistance" do
      object = Settings.new :var => 'foo', :value => 'bar'
      Settings.should_receive(:find_by_var).with('foo').and_return(object)

      Settings.read_from_persistance('foo').should eq 'bar'
    end
  end

  describe :cache_key_for do
    it "returns the name for the rails cache key" do
      Settings.cache_key_for('foo').should eq('settings/foo')
    end
  end

  context "cache" do
    let(:cache) { mock }

    before do
      Rails.should_receive(:cache).and_return cache
      Settings.stub(:cache_key_for).with('foo').and_return 'settings/foo'
    end

    describe :write_to_cache do
      it "writes the key, value to Rails cache" do
        cache.should_receive(:write).with('settings/foo', 'bar')
        Settings.write_to_cache('foo', 'bar')
      end
    end

    describe :read_from_cache do
      it "reads the value from Rails cache" do
        cache.should_receive(:fetch).with('settings/foo')
        Settings.read_from_cache('foo')
      end
    end
  end

  describe :method_missing do
    context "A method ending with =" do
      it "calls define_setter_and_getter" do
        Settings.should_receive(:define_setter_and_getter).with(:new_method=)
        Settings.should_receive(:new_method=).with('value')
        Settings.method_missing(:new_method=, 'value')
      end
    end

    context "method that does not end with =" do
      context "already persisted" do
        before :each do
          @setting = mock(Settings, :var => 'persisted_method', :value => 'some value')
          Settings.stub(:all).and_return([@setting])
        end

        it "pulls the value from the database and creates its setter and getter" do
          Settings.should_receive(:persisted_method=).with('some value')
          Settings.load_from_persistance!
        end
      end

      context "not persisited" do
        it "blows up" do
          lambda {
            Settings.just_a_method
          }.should raise_error(NoMethodError)
        end
      end
    end
  end

  describe :keys do
    let(:settings) do
      [ mock(:var => 'a_key'), mock(:var => 'another_key') ]
    end

    before do
      Settings.should_receive(:select).with(:var).and_return(settings)
    end

    subject { Settings.keys }

    specify { should include(:a_key) }
    specify { should include(:another_key) }
  end

  describe :load_from_persistance! do
    it "loads all settings from persistance and sets it up" do
      settings = [ Settings.new(:var => 'foo', :value => 'bar') ]
      Settings.should_receive(:all).and_return(settings)
      Settings.should_receive("foo=").with('bar')

      Settings.load_from_persistance!
    end
  end

  describe :load_from_persistance do
    context "is ready" do
      before do
        Settings.stub(:ready?).and_return true
      end

      it "calls load_from_persistance!" do
        Settings.should_receive(:load_from_persistance!)
        Settings.load_from_persistance
      end
    end

    context "not ready" do
      before do
        Settings.stub(:ready?).and_return false
      end

      it "calls load_from_persistance!" do
        Settings.should_not_receive(:load_from_persistance!)
        Settings.load_from_persistance
      end
    end
  end

  describe :ready? do
    context "AR is connected and table is created" do
      before do
        Settings.stub(:connected?).and_return true
        Settings.stub(:table_exists?).and_return true
      end

      it "is true" do
        Settings.ready?.should be_true
      end
    end

    context "AR is not connected" do
      before do
        Settings.stub(:connected?).and_return false
        Settings.stub(:table_exists?).and_return true
      end

      it "is false" do
        Settings.ready?.should be_false
      end
    end

    context "table is not created" do
      before do
        Settings.stub(:connected?).and_return false
        Settings.stub(:table_exists?).and_return false
      end

      it "is false" do
        Settings.ready?.should be_false
      end
    end
  end
end
