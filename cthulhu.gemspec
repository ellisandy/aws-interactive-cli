# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cthulhu/version'

Gem::Specification.new do |spec|
  spec.name          = "cthulhu"
  spec.version       = Cthulhu::VERSION
  spec.authors       = ["Jack Ellis"]
  spec.email         = ["andellis@amazon.com"]
  spec.description   = %q{TODO: Write a gem description}
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency "highline/import"
  spec.add_runtime_dependency "aws-sdk"
  spec.add_runtime_dependency "terminal-table"

end

