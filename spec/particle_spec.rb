require_relative 'spec_helper'

describe LD26::Particle do

	before(:each) do
		@particle = LD26::Particle.new
	end

	it "source should default to 0" do
		@particle.source.should == 0
	end
end
