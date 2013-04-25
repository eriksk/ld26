require 'crack'
require 'crack/json'

module Tmx
	class Loader

		def self.load filename, window
			json = nil
			File.open("#{LD26::CONTENT_ROOT}/maps/#{filename}.json", "r") do |f|
				json = Crack::JSON.parse(f.read) 
			end
			create_map_from_json json, window
		end

		private

		def self.create_map_from_json j, window
			width = j["width"]
			height = j["height"]
			tile_width = j["tilewidth"]
			tile_height = j["tileheight"]
			properties = j["properties"]

			images = []
			j["tilesets"].each do |ts|
				img_file = ts["image"].match(/[a-zA-Z_0-9-]*.png/).to_s.gsub(".png", "")
				images << window.load_tiles(img_file, 32, 32)
			end
			
			layers = []
			j["layers"].each do |l|
				layers << Layer.new(l["data"], l["width"], l["height"], l["name"], l["opacity"], l["properties"])
			end

			Map.new(layers, width, height, properties, images, tile_width, tile_height)
		end
	end
end
