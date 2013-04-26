module LD26
	class SkoggySplashScene < Scene
		def initialize game
			super game
			@text = Text.new(window, 256, "Skoggy")
							.set_position(WIDTH / 2.0, HEIGHT + 512)
			@text.color = LD26.color(255, 140, 0)
			@text_presents = Text.new(window, 64, "presents...")
							.set_position(WIDTH / 2.0, (HEIGHT / 2.0) + 196)
			@text_presents.color = LD26.color(0, 0, 0, 0)
			@current = 0.0
			@duration = 3000
		end

		def update dt
			@current += dt

			if @current > @duration / 2.0
				@text_presents.color.alpha = LD26.qlerp(0, 255, @current / @duration)
			end

			if @current < @duration / 2.0
				@text.position.y = LD26.qlerp(HEIGHT + 512, HEIGHT / 2.0, @current / (@duration / 2.0))
			end

			@text.update dt
			@text_presents.update dt
			if @current > @duration || (!window.button_down?(Gosu::KbSpace) & @space_down)
				@game.pop_scene
				@game.push_scene GameScene.new @game
			end
			@space_down = window.button_down?(Gosu::KbSpace)
		end

		def draw
			if @current > 0
				@text.draw
				@text_presents.draw
			end
		end
	end
end
