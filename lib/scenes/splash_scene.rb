module LD26
	class SplashScene < Scene

		def initialize game
			super game
			@logo = Entity.new(game.window.load_image("ld_logo"))
										.set_position(WIDTH / 2.0, -1024)
										.set_scale(0.5)
			@time = 0.0
			@duration = 3000
		end

		def update dt
			@time += dt

			if @time < @duration / 2.0
				@logo.position.y = LD26.qlerp(-1024, HEIGHT / 2.0, @time / (@duration / 2.0))
			else
				@logo.color.alpha = LD26.qlerp(0, 255, (@duration - @time) / (@duration / 2.0))
			end

			if @time > @duration || (!window.button_down?(Gosu::KbSpace) & @space_down)
				@game.pop_scene
				@game.push_scene SkoggySplashScene.new @game
			end
			@space_down = window.button_down?(Gosu::KbSpace)
		end

		def draw
			@logo.draw
		end
	end
end
