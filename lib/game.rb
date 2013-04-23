module LD26
  class Game
    def initialize window
      @window = window
      @bg = window.load_image("bg")
    end
    
    def update dt
    end

    def draw
      @bg.draw(0, 0, 0)
    end
  end
end
