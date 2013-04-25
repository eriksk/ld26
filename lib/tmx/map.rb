module Tmx
	class Map
		attr_accessor :images
		def initialize layers, width, height, properties, tileset, tile_width, tile_height
			@layers = layers
			@width = width
			@height = height
			@properties = properties
			@tileset = tileset 
			@tile_width = tile_width
			@tile_height = tile_height
		end
	
		def update dt
		end

		def draw
			@layers.each do |l|
				l.draw @tileset.first, @tile_width, @tile_height
			end
		end
	end
end
