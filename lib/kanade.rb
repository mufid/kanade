# Kanade core

if File.exists?(File.join(File.dirname(__FILE__), '..', '.devel'))
  puts ' --> WARNING: You are using development mode of this gem'
  require 'pry'
end

module Kanade
  class NotImplementedException < StandardError; end
  class NotSupportedError < StandardError; end
end

# TODO: Dependency to active support to become optional
# require 'active_support/core_ext/class/attribute'
require 'active_support/all'
require 'kanade/all'
