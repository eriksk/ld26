require 'gosu'

module LD26
	class GameWindow < Gosu::Window
		def initialize
			super 800, 600, false
		end
	end
end

game_window = LD26::GameWindow.new
game_window.show
