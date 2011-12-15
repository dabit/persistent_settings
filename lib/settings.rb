class Settings < ActiveRecord::Base
  serialize :value

  def self.method_missing(method_name, *args)
    if assignation?(method_name)
      self.define_setter_and_getter(method_name)
      self.send(method_name, args.first)
    else
      super
    end
  end

  def self.define_setter_and_getter(method_name)
    getter = method_name.to_s.chop

    (class << self; self; end).instance_eval do
      define_method method_name do |value|
        persist(getter, value)
        instance_variable_set(:"@#{getter}", value)
      end

      define_method getter do
        instance_variable_get(:"@#{getter}")
      end
    end
  end

  def self.assignation?(method_name)
    method_name.to_s.match(/=$/)
  end

  def self.persist(getter, value)
    setting = Settings.where(:var => getter).last
    if setting
      setting.update_attribute(:value, value)
    else
      Settings.create(:var => getter, :value => value)
    end
  end

  def self.load_from_persistance
    self.all.each do |setting|
      self.send("#{setting.var}=", setting.value)
    end
  end

  load_from_persistance if connected? && table_exists?
end
