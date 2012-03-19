# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'bookland/version'

Gem::Specification.new do |s|
  s.name        = 'bookland'
  s.version     = Bookland::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Hakan Ensari']
  s.email       = 'hakan.ensari@papercavalier.com'
  s.homepage    = 'https://github.com/hakanensari/bookland'
  s.summary     = %q{EAN and ISBN classes}
  s.description = %q{Bookland provides EAN and ISBN classes.}

  s.add_development_dependency 'rake', '~> 0.9.2'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
end
