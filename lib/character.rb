module LD26
  class Character < Entity
    
    FRICTION = 0.002
    
    def initialize images
      super images.first
      @images = images
      @animations = {
        :idle => Animation.new([0, 1], 500),
        :walk => Animation.new([4, 5], 120)
      }
      @speed = 0.1
      @max_speed = 0.3
      @current_anim = nil
      set_anim :idle
    end

    def set_anim anim
      unless @current_anim == anim
        @current_anim = anim
        @animations[@current_anim].reset()
      end
    end

    def walk direction, dt
      case direction
      when :left
        @velocity.x -= @speed * dt
        @flipped = true
      when :right
        @velocity.x += @speed * dt
        @flipped = false
      end
    end

    def current_anim
      @animations[@current_anim]
    end

    def apply_friction dt
      if @velocity.x > 0.0
        @velocity.x -= FRICTION * dt
        if @velocity.x < 0.0
          @velocity.x = 0.0
        end
      end
      if @velocity.x < 0.0
        @velocity.x += FRICTION * dt
        if @velocity.x > 0.0
          @velocity.x = 0.0
        end
      end
    end

    def update dt
      @behaviors.each{ |b| b.update dt, self }

      @velocity.x = LD26.clamp(@velocity.x, -@max_speed, @max_speed)
      @position.x += @velocity.x * dt
      apply_friction(dt)
      if @velocity.x > 0.0 || @velocity.x < 0.0
        set_anim :walk
      else
        set_anim :idle
      end

      current_anim.update dt
      @image =  @images[current_anim.frame]
    end
  end
end
