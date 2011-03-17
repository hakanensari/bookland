require 'bundler'
require 'rspec/core/rake_task'

Bundler::GemHelper.install_tasks

desc 'Run all specs in spec directory'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
end

task :default => :spec

require 'rocco/tasks'
Rocco::make 'docs/'

desc 'Build rocco docs'
task :docs => :rocco
directory 'docs/'

desc 'Build docs and open in browser for the reading'
task :read => :docs do
  sh 'open docs/lib/bookland/isbn.html'
end
