module LD26
	class GameScene < Scene
		def initialize game
			super game
      @tileset = game.window.load_tiles "tileset", 16, 16
      @grid = []
      size = 32
      size.times do |i|
        @grid << []
        size.times do |j|
          @grid[i] << (rand() * 6).to_i
        end
      end
		end

		def update dt
			if window.button_down? Gosu::KbSpace
				@game.pop_scene
			end
		end

		def draw
      @grid.size.times do |i|
        @grid[i].size.times do |j|
          @tileset[@grid[i][j]].draw(i * 16, j * 16, 0)
        end
      end
		end
	end
end
