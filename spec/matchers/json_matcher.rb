require 'rspec/expectations'

RSpec::Matchers.define :be_json_of do |fixture_name|
  path = File.join(File.dirname(__FILE__), '..', 'fixtures', "#{fixture_name.to_s}.json")
  expected_json = JSON.minify File.read path
  match do |actual|
    # return false unless actual.is_a?(String)
    actual.strip === expected_json.strip
  end
  failure_message do |actual|
    "Expecting #{expected_json}, but got #{actual}"
  end
end
