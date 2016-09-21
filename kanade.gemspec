# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'kanade/version'

Gem::Specification.new do |spec|
  spec.name          = "kanade"
  spec.version       = Kanade::VERSION
  spec.authors       = ["Mufid Afif"]
  spec.email         = ["mufid@outlook.com"]
  spec.summary       = %q{ Strong-typed JSON to Ruby object serializer/deserializer }
  spec.description   = %q{ Strong-typed JSON to Ruby object serializer/deserializer }
  spec.homepage      = "https://github.com/mufid/kanade"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.start_with?("bower_components") || f.start_with?("website") || f.start_with?("bin") || f.start_with?("example")
  end
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  # We use active support inflection, case conversion, and a lot more.
  # Yes yes yes we need to be independent from active support, but this
  # is good enough for now.
  spec.add_dependency "activesupport"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec", "~> 3.5"
  spec.add_development_dependency "timecop"
end
