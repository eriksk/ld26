module LD26
	class Scene
		attr_accessor :game
		def initialize game
			@game = game
		end

		def window
			@game.window
		end

		def update dt
		end

		def draw
		end
	end
end
