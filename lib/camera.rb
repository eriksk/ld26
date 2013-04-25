module LD26
	class Camera
		def initialize window
			@window = window
			@target = Vec2.new
			@origin = Vec2.new WIDTH / 2.0, HEIGHT / 2.0
			@position = Vec2.new -@origin.x, -@origin.y
			@speed = 0.05
		end

		def move x, y
			@target.x, @target.y = x, y
		end

		def update dt
			@position.x = LD26.lerp(@position.x, @target.x, @speed)
			@position.y = LD26.lerp(@position.y, @target.y, @speed)
		end

		def translate &render_code
			@window.translate(-@position.x - @origin.x, -@position.y - @origin.y) do
				render_code.call()
			end
		end
	end
end
