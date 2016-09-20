require_relative 'engine'
require_relative 'dto'
require_relative 'config/default'

require_relative 'naming_strategy/base'
(Dir["#{File.dirname(__FILE__)}/naming_strategy/*.rb"]).each do |path|
  require path
end

require_relative 'converter/base'
(Dir["#{File.dirname(__FILE__)}/converter/*.rb"]).each do |path|
  require path
end

