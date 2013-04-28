module LD26
	class Text < Entity
		def initialize window, size, text
			super nil
			@text = text
			@font = window.load_font size
      @color = LD26.color(TEXT_COLOR.red, TEXT_COLOR.green, TEXT_COLOR.blue)
		end

		def update dt
		end

		def draw
			@font.draw_rel(@text, @position.x, @position.y, 0, @origin.x, @origin.y, @scale, @scale, @color)
		end
	end
end
