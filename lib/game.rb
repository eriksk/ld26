module LD26
  class Game
    def initialize window
      @window = window
      @tileset = window.load_tiles "tileset", 16, 16
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
