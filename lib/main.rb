require 'gosu'
require_relative '../config/config'

module LD26
	class GameWindow < Gosu::Window
		def initialize
			super WIDTH, HEIGHT, FULLSCREEN
			self.caption = TITLE
      @game = Game.new self
		end

    def load_image name
      Gosu::Image.new self, "content/gfx/#{name}.png"
    end

		def button_down(id)
			case id
			when Gosu::KbEscape
				self.close
			end
		end

		def update
			dt = 16.0
      @game.update dt
		end

		def draw
      clear
      @game.draw
		end

    def clear
      draw_quad(
        0, 0, CLEAR_COLORS[0],
        WIDTH, 0, CLEAR_COLORS[1],
        WIDTH, HEIGHT, CLEAR_COLORS[2],
        0, HEIGHT, CLEAR_COLORS[3]
      )
    end
	end
end

game_window = LD26::GameWindow.new
game_window.show
