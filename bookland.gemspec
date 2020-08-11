# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'bookland/version'

Gem::Specification.new do |gem|
  gem.name = 'bookland'
  gem.version = Bookland::VERSION
  gem.authors = ['Hakan Ensari']
  gem.email = 'me@hakanensari.com'
  gem.homepage = 'https://github.com/hakanensari/bookland'
  gem.summary = 'Parse and validate ISBN numbers in Ruby'
  gem.license = 'MIT'

  gem.files = Dir.glob('lib/**/*') + %w[LICENSE README.md]

  gem.add_dependency 'structure', '~> 2.3'
  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rubocop'
  gem.add_development_dependency 'rubocop-performance'
  gem.add_development_dependency 'yard'
  gem.required_ruby_version = '>= 2.5'
end
