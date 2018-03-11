# coding: utf-8
$LOAD_PATH << File.expand_path('../opal', __FILE__)
require 'rubyfy_js/version'

Gem::Specification.new do |spec|
  spec.name          = "rubyfy_js"
  spec.version       = RubyfyJS::VERSION
  spec.authors       = ["Jose Añasco"]
  spec.email         = ["joseanasco1@gmail.com"]

  spec.summary       = %q{Creates Ruby classes from Javascript Code}
  spec.description   = %q{Opinionated way for wrapping js code with Ruby}
  spec.homepage      = "http://github.com/merongivian/rubyfy_js"

  spec.files          = `git ls-files`.split("\n")
  spec.executables    = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.test_files     = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.require_paths  = ['lib']

  spec.add_runtime_dependency 'opal', '~> 0.11.0'
  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
