require_relative 'spec_helper'

describe LD26::ParticleManager do

	before(:each) do
		@manager = LD26::ParticleManager.new nil, []
	end

	it "responds to count" do
		@manager.should respond_to(:count)
	end

	describe "#pop" do
		it "increases count by one" do
			expect{
				@manager.pop()
			}.to change{ @manager.count }.by(1)
		end
	end

	describe "#push" do
		it "decrease count by one" do
			@manager.pop()
			expect{
				@manager.push(0)
			}.to change{ @manager.count }.by(-1)
		end
	end
end
