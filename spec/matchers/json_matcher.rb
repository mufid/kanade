require 'rspec/expectations'

RSpec::Matchers.define :be_json_of do |fixture_name|
  match do |actual|
    actual % expected == 0
  end
end
