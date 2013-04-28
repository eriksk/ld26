module LD26
	class Vec2
		attr_accessor :x, :y
		def initialize x = 0.0, y = 0.0
			@x, @y = x, y
		end

    def self.distance v1, v2
      Math::sqrt(
        ((v1.x - v2.x) * (v1.x - v2.x)) + 
        ((v1.y - v2.y) * (v1.y - v2.y))
      )
    end
	end
end
