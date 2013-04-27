module LD26
	class Camera
		attr_accessor :scale, :rotation, :position, :speed
		def initialize window
			@window = window
			@target = Vec2.new
			@origin = Vec2.new WIDTH / 2.0, HEIGHT / 2.0
			@position = Vec2.new -@origin.x, -@origin.y
			@scale = 1.0
			@speed = 0.05
			@rotation = 0.0
		end

		def move x, y
			@target.x, @target.y = -x, -y
		end

		def update dt
			@position.x = LD26.lerp(@position.x, @target.x, @speed)
			@position.y = LD26.lerp(@position.y, @target.y, @speed)
		end

		def translate parallax = 1.0, &render_code
      parallax = 1.0 if parallax == nil
			@window.translate(((@position.x + @origin.x) * parallax).to_i, ((@position.y + @origin.y) * parallax).to_i) do
  			@window.scale(@scale, @scale, @origin.x, @origin.y) do
	 				@window.rotate(@rotation.to_degrees, @origin.x, @origin.y) do
						render_code.call()
					end
				end
			end
		end
	end
end
