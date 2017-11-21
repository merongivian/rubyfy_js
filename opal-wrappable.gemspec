# coding: utf-8
$LOAD_PATH << File.expand_path('../opal', __FILE__)
require 'wrappable/version'

Gem::Specification.new do |spec|
  spec.name          = "opal-wrappable"
  spec.version       = Opal::Wrappable::VERSION
  spec.authors       = ["Jose Añasco"]
  spec.email         = ["joseanasco1@gmail.com"]

  spec.summary       = %q{Generates opal classes from javascript}
  spec.description   = %q{Opinionated way for wrapping js code with Ruby}
  spec.homepage      = "http://github.com/merongivian/opal-wrappable"

  spec.files          = `git ls-files`.split("\n")
  spec.executables    = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.test_files     = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.require_paths  = ['lib']

  spec.add_runtime_dependency 'opal', '~> 0.10.2'
  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
