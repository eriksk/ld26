module LD26
  class Enemy < Entity
    def initialize window
      super nil
      @images = window.load_tiles("enemy", 16, 16)
      @image = @images.first
      @animation = Animation.new([0, 1], 100)
      @speed = 0.05
    end

    def left
      @position.x - @image.width / 2.0
    end

    def right
      @position.x + @image.width / 2.0
    end

    def update dt, map
      col = nil
      if @flipped
        col = (left / 16.0).to_i
      else
        col = (right / 16.0).to_i
      end
      row = (@position.y / 16.0).to_i
      if map.layers.first.get_cell(col, row, false) > 1
        @flipped = !@flipped
      end

      if @flipped
        @position.x -= @speed * dt
      else
        @position.x += @speed * dt
      end
      @animation.update dt
      @image = @images[@animation.frame]  
    end
  end
end
