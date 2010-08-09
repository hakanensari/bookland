unless defined?(Bundler)
  require "rubygems"
  require "bundler/setup"
end

require "rspec"
require "yaml"

require File.expand_path("../../lib/bookland", __FILE__)

def isbns
  File.open(File.expand_path("../fixtures/isbn", __FILE__)).each do |line|
    yield line.split
  end
end
