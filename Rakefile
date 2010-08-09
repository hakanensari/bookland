require "rubygems"
require "bundler/setup"
require "jeweler"
require "rspec/core/rake_task"

desc "Run all specs in spec directory"
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = "spec/**/*_spec.rb"
end

Jeweler::Tasks.new do |gemspec|
  gemspec.name = "bookland"
  gemspec.summary = "A simple ISBN class in Ruby"
  gemspec.description = "A simple ISBN class in Ruby"
  gemspec.email = "code@papercavalier.com"
  gemspec.homepage = "http://github.com/papercavalier/bookland"
  gemspec.authors = ["Hakan Ensari", "Piotr Laszewski"]
end

Jeweler::GemcutterTasks.new

task :default => :spec
