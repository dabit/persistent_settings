Given /^I assign "([^"]*)" to "([^"]*)"$/ do |value, key|
  eval "Settings.#{key} = #{value}"
end

Then /^Settings should respond to "([^"]*)"$/ do |key|
  Settings.should respond_to(key)
end

Then /^"([^"]*)" should hold "([^"]*)"$/ do |key, value|
  Settings.send(key).should eq(value)
end

Then /^Settings\.keys should include:$/ do |table|
  table.raw.flatten.each do |key|
    Settings.keys.should include(key.to_sym)
  end
end
