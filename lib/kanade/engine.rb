class Kanade::Engine
  def initialize
    @config =
  end
  def configure
    yield @config
  end
  def serialize
  end

  def deserialize
  end
end
