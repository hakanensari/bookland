# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'bookland/version'

Gem::Specification.new do |s|
  s.name        = 'bookland'
  s.version     = Bookland::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Paper Cavalier']
  s.email       = 'code@papercavalier.com'
  s.homepage    = 'https://rubygems.org/gems/bookland'
  s.summary     = %q{An ISBN class in Ruby}
  s.description = %q{Bookland is an ISBN class in Ruby.}

  s.rubyforge_project = 'bookland'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_development_dependency('rspec', '~> 2.5.0')
end
