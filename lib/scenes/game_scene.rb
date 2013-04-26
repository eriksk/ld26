module LD26
	class GameScene < Scene
		def initialize game
			super game
			@map = Tmx::Loader.load "test", game.window
			@cam = Camera.new window
		end

		def update dt
			if window.button_down? Gosu::KbSpace
				@game.pop_scene
			end
			@map.update dt
			@cam.move -WIDTH / 2.0, -100
			@cam.update dt
		end

		def draw
			@cam.translate do
				@map.draw
			end
		end
	end
end
