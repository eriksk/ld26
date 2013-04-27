module LD26
	class Entity
		attr_accessor :image, :position, :origin, :velocity, :rotation, :scale, :color, :flipped

		def initialize image
			@image = image
			@position = Vec2.new
			@origin = Vec2.new 0.5, 0.5
			@velocity = Vec2.new
			@rotation = 0.0
			@scale = 1.0
			@color = LD26.color()
			@behaviors = []
      @flipped = false
		end

		def add_behavior behavior
			@behaviors << behavior
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

    def left
      @position.x - @image.width / 2.0
    end
    def right
      @position.x + @image.width / 2.0
    end
    def top
      @position.y - @image.height / 2.0
    end
    def bottom
      @position.y + @image.height / 2.0
    end

    def collides_with? other
      Vec2.distance(@position, other.position) < 8
    end

		def update dt
      @behaviors.each do |b|
        b.update dt, self
      end
		end

		def draw
      if flipped
			  @image.draw_rot(@position.x, @position.y, 0, @rotation.to_degrees, @origin.x, @origin.y, -@scale, @scale, @color)
      else
			  @image.draw_rot(@position.x, @position.y, 0, @rotation.to_degrees, @origin.x, @origin.y, @scale, @scale, @color)
      end
		end
	end
end
