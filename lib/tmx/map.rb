module Tmx
	class Map
		attr_accessor :images, :layers, :width, :height, :tile_width, :tile_height
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

    def clear_enemy_data
      @layers.each do |l|
        l.data.size.times do |i|
          if l.data[i] -1 == 32
            l.data[i] = 0
          end
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
