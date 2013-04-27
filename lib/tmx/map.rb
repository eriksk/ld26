module Tmx
	class Map
		attr_accessor :images, :layers
		def initialize window, layers, width, height, properties, tileset, tile_width, tile_height
			@layers = layers
			@width = width
			@height = height
			@properties = properties
			@tileset = tileset 
			@tile_width = tile_width
			@tile_height = tile_height
			@layers.each{ |l| l.pre_render window, @tileset.first, @tile_width, @tile_height }
		end
	
		def update dt
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
