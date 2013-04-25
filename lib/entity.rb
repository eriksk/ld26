module LD26
	class Entity
		attr_accessor :image, :position, :origin, :velocity, :rotation, :scale

		def initialize image
			@image = image
			@position = Vec2.new
			@origin = Vec2.new 0.5, 0.5
			@velocity = Vec2.new
			@rotation = 0.0
			@scale = 1.0
			@color = LD26.color()
			@behaviors = []
		end

		def add_behavior behavior
			behaviors << behavior
			self
		end

		def set_position x, y
			@position.x, @position.y = x, y
			self
		end

		def set_scale scale
			@scale = scale
			self
		end

		def update dt
		end

		def draw
			@image.draw_rot(@position.x, @position.y, 0, @rotation.to_degrees, @origin.x, @origin.y, @scale, @scale, @color)
		end
	end
end
