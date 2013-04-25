module LD26
  class Game
		attr_accessor :window
    def initialize window
      @window = window
			@scenes = []
			push_scene SkoggySplashScene.new self
    end

		def pop_scene
			log "Popping scene: #{@scenes.last.class}"
			@scenes.delete_at(@scenes.size - 1)
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
    end
  end
end


