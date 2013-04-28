module Tmx
	class Map
		attr_accessor :images, :layers, :width, :height, :tile_width, :tile_height, :properties
		def initialize window, layers, width, height, properties, tileset, tile_width, tile_height
			@layers = layers
			@width = width
			@height = height
			@properties = properties
			@tileset = tileset 
			@tile_width = tile_width
			@tile_height = tile_height
		end

    def pre_render window
			@layers.each{ |l| l.pre_render window, @tileset.first, @tile_width, @tile_height }
    end

    def clear_data cells = []
      @layers.each do |l|
        l.data.size.times do |i|
          cells.each do |cell|
            if l.data[i] -1 == cell
              l.data[i] = 0
            end
          end
        end
      end
    end

    def fade_in_all
        @width.times do |col|
          @height.times do |row|
           get_cell col, row
          end
        end
    end

    def get_start
      x, y = @properties["start"].split(":")
      x = x.to_i * @tile_width
      y = y.to_i * @tile_height
      LD26::Vec2.new(x, y)
    end

    def get_end_cell
      x, y = @properties["end"].split(":")
      x = x.to_i
      y = y.to_i
      LD26::Vec2.new(x, y)
    end

    def get_cell col, row, fade = true
      @layers.each do |l|
        l.get_cell col, row
      end
      @layers.first.get_cell col, row
    end

    def collide_x p
      col = (p.left / 16.0).to_i
      row = (p.position.y / 16.0).to_i
      if get_cell(col, row) > 0
        p.position.x = ((p.position.x / 16.0).to_i * 16.0) + 8.0
        p.velocity.x = 0.0
      end
      col = (p.right / 16.0).to_i
      if get_cell(col, row) > 0
        p.position.x = ((p.position.x / 16.0).to_i * 16.0) + 8
        p.velocity.x = 0.0
      end
    end

    def collide_y p
      col = (p.position.x / 16.0).to_i
      row = ((p.position.y + p.image.height / 2.0) / 16.0).to_i
      if get_cell(col, row) > 0
        if p.grounded
        else
          p.land
          p.position.y = (row * 16.0) - 8.0
        end
      end
      row = ((p.position.y - p.image.height / 2.0) / 16.0).to_i
      if get_cell(col, row) > 0
        if p.grounded
        else
          p.velocity.y = 0.0
          p.position.y = ((p.position.y / 16.0).to_i * 16.0) + 8
        end
      end
      # check for ground
      if p.grounded
        row = ((p.position.y + p.image.height + 1 / 2.0) / 16.0).to_i
        if get_cell(col, row) == 0
          p.fall_off
        end
      end
    end
	
		def update dt
      @layers.each{ |l| l.update dt}
		end

		def draw cam
			@layers.each do |l|
        cam.translate l.parallax do
				  l.draw
        end
			end
		end
	end
end
