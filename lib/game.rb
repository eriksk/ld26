module LD26
  class Game
		attr_accessor :window
    def initialize window
      @window = window
			@scenes = []
			push_scene SplashScene.new self
=begin
      @tileset = window.load_tiles "tileset", 16, 16
      @grid = []
      size = 32
      size.times do |i|
        @grid << []
        size.times do |j|
          @grid[i] << (rand() * 6).to_i
        end
      end
=end
    end

		def pop_scene
			@scenes.delete(@scenes.size - 1)
		end

		def push_scene scene
			@scenes.push scene
		end

		def current_scene
			@scenes.last
		end
    
    def update dt
			if @scenes.empty?
				log "No scenes remaining, closing game"
				@window.close
			else
				current_scene.update dt
			end
    end

    def draw
			unless @scenes.empty?
				current_scene.draw
			end
=begin
      @grid.size.times do |i|
        @grid[i].size.times do |j|
          @tileset[@grid[i][j]].draw(i * 16, j * 16, 0)
        end
      end
=end
    end
  end
end
