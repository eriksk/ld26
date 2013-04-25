module LD26
	class SplashScene < Scene

		def initialize game
			super game
			@logo = Entity.new(game.window.load_image("ld_logo"))
										.set_position(WIDTH / 2.0, HEIGHT / 2.0)
										.set_scale(0.5)
		end

		def draw
			@logo.draw
		end
	end
end
