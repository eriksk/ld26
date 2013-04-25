module LD26
	WIDTH = 1280
	HEIGHT = 720
	FULLSCREEN = false
	TITLE = "Ludum Dare 26 (Skoggy)"
  DEBUG = true
  CLEAR_COLORS = [
    Gosu::Color::WHITE,
    Gosu::Color::WHITE,
    Gosu::Color::GRAY,
    Gosu::Color::GRAY
  ]
end

def log message
	if LD26::DEBUG
		puts "#{caller[0][/lib\/.*/]}: #{message}" # puts calling class
	end
end

def req file
  require_relative "../lib/#{file}"
end
def req_dir d
	dir = "lib/#{d}/*"
	Dir.glob(dir).each{ |f| 
		filename = File.basename(f)
		require_relative "../lib/#{d}/#{filename}"
	}
end

req "vec2"
req "camera"
req "helpers"
req "entity"
req "text"
req "scene"
req_dir "scenes"

# tmx
req "tmx/layer"
req "tmx/map"
req "tmx/tmx_loader"

req "game"
