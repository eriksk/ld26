module LD26
	class Particle
		attr_accessor :source, :x, :y, :vel_x, :vel_y, :rotation, :scale, :origin_x, :origin_y, :color, :current, :duration
		def initialize
			@source = 0
			@x, @y = 0, 0
			@rotation = 0.0
			@scale = 1.0
			@origin_x = 0.5
			@origin_y = 0.5
			@color = LD26.color()
			@current = 0.0
			@duration = 1000
		end
	end
end
