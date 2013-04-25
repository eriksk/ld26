module LD26
	class GameScene < Scene
		def initialize game
			super game
			@map = Tmx::Loader.load "test", game.window
		end

		def update dt
			if window.button_down? Gosu::KbSpace
				@game.pop_scene
			end
			@map.update dt
		end

		def draw
			@map.draw
		end
	end
end
