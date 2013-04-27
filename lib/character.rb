module LD26
  class Character < Entity
    attr_accessor :grounded
    
    FRICTION = 0.002
    
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

    def left
      @position.x - @image.width / 2.0
    end
    def right
      @position.x + @image.width / 2.0
    end
    def top
      @position.y - @image.height / 2.0
    end
    def bottom
      @position.y + @image.height / 2.0
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
      gravity  = 0.00098
      unless @grounded
        @velocity.y += gravity * dt
      end
    end

    def collide dt, map
      # x - collision
      if collides_left? map
        @velocity.x = 0.0
        @position.x = ((@position.x / 16.0).to_i * 16.0) + 8.0
      end
      if collides_right? map
        @velocity.x = 0.0
        @position.x = ((@position.x / 16.0).to_i * 16.0) + 8.0
      end

      # y - collision
      if @grounded
        if !has_floor? map
          fall_off()
        end
      else
        if @velocity.y > 0.0
          if has_floor? map
            land()
            @position.y = ((@position.y / 16.0).to_i * 16.0) + 8.0
          end
        else
          if bump_head? map
            fall_off()
            @position.y = ((@position.y / 16.0).to_i * 16.0) + 8.0
          end
        end
      end
    end

    def collides_left? map
      col = (left / 16.0).to_i
      row = (@position.y / 16.0).to_i
      cell = map.layers.first.get_cell col, row
      cell > 1
    end
    def collides_right? map
      col = (right / 16.0).to_i
      row = (@position.y / 16.0).to_i
      cell = map.layers.first.get_cell col, row
      cell > 1
    end

    def has_floor? map
      col = (@position.x / 16.0).to_i
      row = (bottom / 16.0).to_i
      cell = map.layers.first.get_cell col, row
      cell > 1
    end

    def bump_head? map
      col = (@position.x / 16.0).to_i
      row = (top / 16.0).to_i
      cell = map.layers.first.get_cell col, row
      cell > 1
    end

    def update dt, map
      @behaviors.each{ |b| b.update dt, self }
      @velocity.x = LD26.clamp(@velocity.x, -@max_speed, @max_speed)
      @position.x += @velocity.x * dt
      @position.y += @velocity.y * dt
      apply_friction(dt)
      collide(dt, map)
      apply_gravity dt
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