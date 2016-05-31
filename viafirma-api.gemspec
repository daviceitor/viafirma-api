# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'viafirma/api/version'
require 'viafirma/facade'


Gem::Specification.new do |spec|
  spec.name          = "viafirma-api"
  spec.version       = Viafirma::Api::VERSION
  spec.authors       = ["David García Lorigados"]
  spec.email         = ["dglo1985@gmail.com"]
  spec.summary       = %q{API for connect and manage e-sign with viafirma platform}
  spec.description   = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "debugger"

  spec.add_dependency "savon"
  spec.add_dependency "activesupport"
end
