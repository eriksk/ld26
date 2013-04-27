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
          @touches[i] << LD26::Touch.new
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
                touch = @touches[col + i][row + j]
                if touch.state == :none
                  touch.alpha = 0.0
                  touch.state = :fade_in
                elsif touch.state == :fade_out
                  touch.alpha = 255
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
      fade_in_speed = 0.1
      fade_out_speed = 0.1
      @touches.size.times do |col|
        @touches[col].size.times do |row|
          touch = @touches[col][row]
          case touch.state
          when :none
          when :fade_in
            touch.alpha += fade_in_speed * dt
            if touch.alpha > 255
              touch.alpha = 255
              touch.state = :fade_out
            end
          when :fade_out
            touch.alpha -= fade_out_speed * dt
            if touch.alpha < 0.0
              touch.alpha = 0
              touch.state = :none
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
            touch = @touches[col][row]
            if touch.state != :none
              cell = @data[col + row * @width] - 1
              color.alpha = touch.alpha
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
