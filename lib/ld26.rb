require 'gosu'
require_relative 'config'

module LD26
	class GameWindow < Gosu::Window
		def initialize
			super WIDTH, HEIGHT, FULLSCREEN
			self.caption = TITLE
      @game = Game.new self
      @last_frame = Gosu::milliseconds
      @dt = 0.0
      @fps = 0.0
      @update_fps = 0.0
      @font = Gosu::Font.new self, Gosu::default_font_name, 24
		end

    def load_song name
      Gosu::Song.new self, "#{CONTENT_ROOT}/audio/#{name}.wav"
    end

    def load_image name
      Gosu::Image.new self, "#{CONTENT_ROOT}/gfx/#{name}.png"
    end

    def load_tiles name, width, height
      Gosu::Image.load_tiles self, "#{CONTENT_ROOT}/gfx/#{name}.png", width, height, true
    end

		def load_font size
			Gosu::Font.new self, "#{CONTENT_ROOT}/fonts/#{FONT_NAME}.ttf", size
		end

		def button_down(id)
			case id
			when Gosu::KbEscape
        if DEBUG
				  self.close
        end
			end
		end

    def update_delta
      this_frame = Gosu::milliseconds
      @dt = this_frame - @last_frame
      @last_frame = this_frame
      @update_fps -= @dt
      if @update_fps < 0.0
        @fps = 1000.0 / @dt
        @update_fps = 500.0
      end
    end

		def update
      update_delta
      @game.update @dt
		end

		def draw
      clear
      @game.draw
      if DEBUG
        @font.draw("FPS: #{@fps.to_i}", 16, 16, 0, 1, 1, Gosu::Color::BLACK)
      end
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
