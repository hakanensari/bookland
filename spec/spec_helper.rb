require File.expand_path("../../lib/bookland", __FILE__)

require "rspec"
require "yaml"

def isbns
  File.open(File.expand_path("../fixtures/isbn", __FILE__)).each do |line|
    yield line.split
  end
end