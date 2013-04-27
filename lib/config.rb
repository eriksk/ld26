module LD26
	WIDTH = 1280
	HEIGHT = 720
	FULLSCREEN = false
	TITLE = "Ludum Dare 26 (Skoggy)"
  DEBUG = true
	CONTENT_ROOT = "#{File.dirname(__FILE__)}/content"
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
  require_relative "#{file}"
end
def req_dir d
	dir = "#{File.dirname(__FILE__)}/#{d}/*"
	Dir.glob(dir).each{ |f| 
		filename = File.basename(f)
		require_relative "#{d}/#{filename}"
	}
end

req "json_parser"
req "vec2"
req "rectangle"
req "camera"
req "audio_manager"
req "helpers"
req "animation"
req "particle"
req "particle_manager"
req "character_factory"
req "entity"
req_dir "behaviors"
req "character"
req "enemy"
req "touch"
req "text"
req "scene"
req_dir "scenes"

# tmx
req "tmx/layer"
req "tmx/map"
req "tmx/tmx_loader"

req "game"
