require_relative 'engine'
require_relative 'dto'
require_relative 'config/default'
require_relative 'field_info'

require_relative 'naming_strategy/base'
(Dir["#{File.dirname(__FILE__)}/naming_strategy/*.rb"].reject{|x| x.match(/base/) }).each do |path|
  require path
end

require_relative 'converter/base'
(Dir["#{File.dirname(__FILE__)}/converter/*.rb"].reject{|x| x.match(/base/) }).each do |path|
  require path
end
