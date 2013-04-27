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

      if entity.grounded
        if @window.button_down?(Gosu::KbSpace)
          entity.jump dt
        end
      else
      end
    end
  end
end
