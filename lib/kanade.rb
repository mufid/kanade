# TODO: Dependency to active support to become optional
# require 'active_support/core_ext/class/attribute'
require 'active_support/all'
require 'kanade/all'

module Kanade
  class NotImplementedException < StandardError; end
end
