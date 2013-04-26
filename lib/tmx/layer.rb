module Tmx
	class Layer 
		def initialize data, width, height, name, opacity, properties
			@data = data
			@width = width
			@height = height
			@name = name
			@opacity = opacity
			@properties = properties
			@color = LD26.color(255, 255, 255, (255.0 * opacity).to_i)
		end

		def update dt
		end

		def draw images, tile_width, tile_height
			images.size
			@width.times do |col|
				@height.times do |row|
					cell = @data[col + row * @width] - 1
					unless cell == -1
						images[cell].draw(col * tile_width, row * tile_height, 0, 1, 1, @color)
					end
				end
			end
		end
	end
end
