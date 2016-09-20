module Kanade
  class Config
    def self.default
      Config.new
    end

    attr_accessor :contract
    attr_accessor :enum
  end
end
