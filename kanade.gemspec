# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'kanade/version'
devel = false

if File.exists?(File.join(File.dirname(__FILE__), '.devel'))
  puts ' --> WARNING: You are using development mode of this gem'
  devel = true
end

Gem::Specification.new do |spec|
  spec.name          = "kanade"
  spec.version       = Kanade::VERSION
  spec.authors       = ["Mufid Afif"]
  spec.email         = ["mufid@outlook.com"]
  spec.summary       = %q{ Strong-typed JSON to Ruby object serializer/deserializer }
  spec.description   = %q{ Strong-typed JSON to Ruby object serializer/deserializer }
  spec.homepage      = "https://github.com/mufid/kanade"
  spec.license       = "MIT"

  rejected = %w{ .yardoc .devel .editorconfig .gitignore .rspec .travis.yml doc Gemfile.lock Rakefile kanade.gemspec pkg }

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    r = false
    rejected.each do |term|
      r ||= f.start_with?(term)
    end
    puts "Rejected: #{f}" if r and devel
    puts "Included: #{f}" if not r and devel
    r
  end
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
