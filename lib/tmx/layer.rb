module Tmx
	class Layer 
		def initialize data, width, height, name, opacity, properties
			@data = data
			@width = width
			@height = height
			@name = name
			@opacity = opacity
			@properties = properties
			p opacity
			@color = LD26.color(255, 255, 255, (255.0 * opacity).to_i)
		end

		def update dt
		end

		def draw images, tile_width, tile_height
			@data.each_with_index do |cell, index|
				unless cell == 0
					col = index % @width
					row = index / @height
					images[cell - 1].draw(col * tile_width, row * tile_height, 0, 1, 1, @color)
				end
			end
		end
	end
end
