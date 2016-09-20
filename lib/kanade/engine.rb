require 'json'

class Kanade::Engine
  def initialize(configuration=nil)
    @config = configuration || Kanade::Config.default
  end
  def configure
    yield @config
  end
  def serialize(object)
    object.to_hash.to_json
  end

  def deserialize(object)
  end
end
