require_relative 'spec_helper'

describe LD26::Character do
  
  before(:each) do
    @character =  LD26::Character.new ["test"]
  end

  it "divides to correct cell" do
    (124.8 / 16.0).should be(7)
  end
end
