module Tmx
	class Layer 
    attr_reader :parallax, :data
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
      @touches = []
      width.times do |i|
        @touches << []
        height.times do |j|
          @touches[i] << nil
        end
      end
      @images = nil
		end

		def pre_render window, images, tile_width, tile_height
        @images = images
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

    def get_cell col, row, fade_in_cell = true
      if col > -1 && col < @width && row > -1 && row < @height
        if fade_in_cell
          (-4..3).each do |i|
            (-4..3).each do |j|
              if col + i > -1 && col + i < @width && row + j > -1 && row + j < @height
                if @touches[col + i][row + j] == nil
                  @touches[col + i][row + j] = 0.0
                end
              end
            end
          end
        end
        return @data[col + row * @width]
      end
      -1
    end

		def update dt
      @touches.size.times do |col|
        @touches[col].size.times do |row|
          if @touches[col][row] && @touches[col][row] < 255
            @touches[col][row] += 0.05 * dt
            if @touches[col][row] > 255
              @touches[col][row] = 255
            end
          end
        end
      end
		end

		def draw 
			if @properties && @properties["hidden"]
        color = LD26.color()
        @touches.size.times do |col|
          @touches[col].size.times do |row|
            if @touches[col][row] != nil
              cell = @data[col + row * @width] - 1
              color.alpha = @touches[col][row]
              @images[cell].draw(col * 16, row * 16, 0, 1.0, 1.0, color)
            end
          end
        end
      else
			  @pre_rendered_image.draw(0, 0, 0)
      end
		end
	end
end
