# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bookland/version'

Gem::Specification.new do |spec|
  spec.name        = 'bookland'
  spec.version     = Bookland::VERSION
  spec.authors     = ['Hakan Ensari']
  spec.email       = 'hakan.ensari@papercavalier.com'
  spec.description = %q{An ISBN toolkit}
  spec.summary     = %q{An ISBN toolkit}
  spec.homepage    = 'https://github.com/hakanensari/bookland'
  spec.license     = 'MIT'

  spec.files         = `git ls-files`.split("\n")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest', '~> 5.0'
end
