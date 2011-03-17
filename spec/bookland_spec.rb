require 'spec_helper'

describe Bookland do
  it "includes itself in the global namespace" do
    defined?(ISBN).should eql 'constant'
  end
end
