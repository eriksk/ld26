module LD26
  class Spike < Entity
    attr_accessor :falling
    def initialize window
      super window.load_image('spike')
      @falling = false
    end

    def fall
      @falling = true
    end
    
    def update dt
      if @falling
        gravity = 0.000098
        @velocity.y += gravity * dt
        @position.y += @velocity.y * dt
      end
    end
  end
end
