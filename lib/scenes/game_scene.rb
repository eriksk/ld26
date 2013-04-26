module LD26
	class GameScene < Scene
		def initialize game
			super game
			@map = Tmx::Loader.load "test", game.window
			@cam = Camera.new window
			@pixel = Vec2.new WIDTH / 2.0, HEIGHT / 2.0
			@timer = 0
		end

		def update dt
			if window.button_down? Gosu::KbSpace
				@game.pop_scene
			end
			@map.update dt
			@cam.move @pixel.x, @pixel.y
			@cam.update dt
			
			@timer += dt
			@pixel.x = (WIDTH / 2.0) + Math::cos(@timer * 0.001) * 300
			@pixel.y = (HEIGHT / 2.0) + Math::sin(@timer * 0.001) * 300
			@cam.scale = 1.0 + Math::cos(@timer * 0.001)
			@cam.rotation += 0.001 * dt
		end

		def draw
			@cam.translate do
				@map.draw
			end
				window.draw_line(
					WIDTH / 2.0, HEIGHT / 2.0, Gosu::Color::BLACK,
					@pixel.x , @pixel.y, Gosu::Color::RED
				)
		end
	end
end
