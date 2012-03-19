require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new do |test|
  test.libs += %w{lib test}
  test.test_files = FileList['test/**/*_test.rb']
end

task :default => :test
