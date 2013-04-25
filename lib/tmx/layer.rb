module Tmx
	class Layer 
		def initialize data, width, height, name, opacity, properties
			@data = data
			@width = width
			@height = height
			@name = name
			@opacity = opacity
			@properties = properties
		end

		def update dt
		end

		def draw images, tile_width, tile_height
			@data.each_with_index do |cell, index|
				unless cell == 0
					col = index % @width
					row = index / @height
					images[cell - 1].draw(col * tile_width, row * tile_height, 0)
				end
			end
		end
	end
end
