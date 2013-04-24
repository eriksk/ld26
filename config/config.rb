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

def req file
  require_relative "../lib/#{file}"
end

req "game"
