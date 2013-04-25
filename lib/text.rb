module LD26
	class Text < Entity
		def initialize window, size, text
			super nil
			@text = text
			@font = window.load_font size
			@shadow_color = LD26.color(0, 0, 0, 100)
		end

		def update dt
			@shadow_color.alpha = LD26.lerp(0, 50, @color.alpha.to_f / 255.0)
		end

		def draw
			@font.draw_rel(@text, @position.x + 2, @position.y - 2, 0, @origin.x, @origin.y, @scale, @scale, @shadow_color)
			@font.draw_rel(@text, @position.x, @position.y, 0, @origin.x, @origin.y, @scale, @scale, @color)
		end
	end
end
