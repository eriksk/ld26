module LD26
  class PlayerMovementBehavior
    def initialize window
      @window = window
    end

    def update dt, entity
      if @window.button_down?(Gosu::KbLeft) 
        entity.walk(:left, dt)
      end
      if @window.button_down?(Gosu::KbRight) 
        entity.walk(:right, dt)
      end
    end
  end
end
