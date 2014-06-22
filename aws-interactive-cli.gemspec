# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'aws_interactive_cli/version'

Gem::Specification.new do |spec|
  spec.name          = "aws_interactive_cli"
  spec.version       = AWSInteractiveCLI::VERSION
  spec.authors       = ["Jack Ellis"]
  spec.email         = ["andellis@amazon.com"]
  spec.description   = ["Interactive AWS CLI"]
  spec.summary       = ["Easy way to start, stop, and ssh into instances"]
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency "highline"
  spec.add_runtime_dependency "aws-sdk"
  spec.add_runtime_dependency "terminal-table"

end

