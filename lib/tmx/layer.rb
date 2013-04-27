module Tmx
	class Layer 
    attr_reader :parallax
		def initialize data, width, height, name, opacity, properties
			@data = data
			@width = width
			@height = height
			@name = name
			@opacity = opacity
			@properties = properties
			@color = LD26.color(255, 255, 255, (255.0 * opacity).to_i)
			@pre_rendered_image = nil
      @parallax = nil
      @parallax = properties["parallax"].to_f if properties && properties["parallax"] 
		end

		def pre_render window, images, tile_width, tile_height
				@pre_rendered_image = window.record(@width * tile_width, @height * tile_height) do
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

    def get_cell col, row
      if col > -1 && col < @width && row > -1 && row < @height
        return @data[col + row * @width]
      end
      -1
    end

		def update dt
		end

		def draw 
			unless @properties && @properties["hidden"]
				@pre_rendered_image.draw(0, 0, 0)
			end
		end
	end
end
