module LD26
	class SkoggySplashScene < Scene
		def initialize game
			super game
			@text = Text.new(window, 256, "Skoggy")
							.set_position(WIDTH / 2.0, HEIGHT / 2.0)
			@text.color = LD26.color(0, 0, 0)
			@current = 0.0
			@duration = 5000
		end

		def update dt
			@current += dt
			@text.update dt

			if @current > @duration
				@game.pop_scene
			end
		end

		def draw
			@text.draw
		end
	end
end
