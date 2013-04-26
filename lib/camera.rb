module LD26
	class Camera
		attr_accessor :scale, :rotation
		def initialize window
			@window = window
			@target = Vec2.new
			@origin = Vec2.new WIDTH / 2.0, HEIGHT / 2.0
			@position = Vec2.new -@origin.x, -@origin.y
			@scale = 1.5
			@speed = 1.0 # 0.05
			@rotation = 0.0
		end

		def move x, y
			@target.x, @target.y = -x, -y
		end

		def update dt
			@position.x = LD26.lerp(@position.x, @target.x, @speed)
			@position.y = LD26.lerp(@position.y, @target.y, @speed)
		end

		def translate &render_code
			@window.translate(-@position.x - @origin.x, -@position.y - @origin.y) do
				@window.scale(@scale, @scale, @origin.x, @origin.y) do
					@window.rotate(@rotation.to_degrees, @origin.x, @origin.y) do
						render_code.call()
					end
				end
			end
		end
	end
end
