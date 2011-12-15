require 'spec_helper'

describe Settings do
  before do
  end
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
    it "creates the setter and getter methods" do
      Settings.define_setter_and_getter(:method_name=)
      Settings.should respond_to(:method_name=)
      Settings.should respond_to(:method_name)
      Settings.should_receive(:persist)
      Settings.method_name = 'value'
      Settings.method_name.should == 'value'
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
          Settings.load_from_persistance
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
end
