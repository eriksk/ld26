module LD26
  class Character < Entity
    attr_accessor :grounded
    
    FRICTION = 0.002
    GRAVITY = 0.0007
    
    def initialize images
      super images.first
      @images = images
      @animations = {
        :idle => Animation.new([0, 1], 500),
        :walk => Animation.new([4, 5], 120)
      }
      @grounded = false
      @speed = 0.05
      @max_speed = 0.2
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

    def land
      @velocity.y = 0.0
      @grounded = true
    end

    def jump dt
      @velocity.y = -0.3
      @grounded = false
    end

    def fall_off
      @velocity.y = 0.0
      @grounded = false
    end

    def apply_gravity dt
      unless @grounded
        @velocity.y += GRAVITY * dt
      end
    end

    def get_bounding
      Rectangle.new(left.to_i, top.to_i, @image.width, @image.height)
    end

    def collide_x dt, map
      map.collide_x self
    end

    def collide_y dt, map
      map.collide_y self
    end

    def update dt, map
      @velocity.x = LD26.clamp(@velocity.x, -@max_speed, @max_speed)
      apply_friction(dt)

      @position.x += @velocity.x * dt
      collide_x(dt, map)
      
      apply_gravity dt
      @position.y += @velocity.y * dt
      collide_y(dt, map)

      @behaviors.each{ |b| b.update dt, self }

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
