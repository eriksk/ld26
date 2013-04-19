require 'gosu'
require_relative '../config/config'

module LD26
	class GameWindow < Gosu::Window
		def initialize
			super WIDTH, HEIGHT, FULLSCREEN
			self.caption = TITLE
		end

		def button_down(id)
			case id
			when Gosu::KbEscape
				self.close
			end
		end

		def update
			dt = 16.0
		end

		def draw
		end
	end
end

game_window = LD26::GameWindow.new
game_window.show
