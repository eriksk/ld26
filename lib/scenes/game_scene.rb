module LD26
	class GameScene < Scene
		def initialize game
			super game
      @filter = window.load_image("filter")
			@cam = Camera.new window
      @font = window.load_font 64
      @state = :loading
      @current_level = 2
      @last_level = 3
      next_level
		end

    def reached_end?
      x = (@player.position.x / 16.0).to_i
      y = (@player.position.y / 16.0).to_i
      @end.x == x && @end.y == y
    end

    def next_level
      @state = :loading
      @current_level += 1
      unless @current_level > @last_level
        load_level
      else
        @game.pop_scene
        @game.push_scene SplashScene.new @game
      end
    end

    def load_level
      @map = Tmx::Loader.load "map_#{@current_level}", game.window
      @intro_text = Text.new window, 128, @map.properties["name"]
      @intro_current = 0.0
      @intro_duration = 3000
      @start_pos = @map.get_start
      @player = CharacterFactory.create(window, :player)
        .set_position(@start_pos.x, @start_pos.y)
      @player.grounded = false
      @player.velocity.y = 0.0
      @end = @map.get_end_cell
      @characters = []
      @characters << @player
      @particle_manager = ParticleManager.new window.load_tiles("particles", 8, 8)
      @enemies = []
      l = @map.layers.first
      @map.width.times do |col|
        @map.height.times do |row|
          cell = l.data[col + row * @map.width] - 1
          if cell == 32
            @enemies << CharacterFactory.create(window, :enemy)
              .set_position((col * @map.tile_width) + 8, (row * @map.tile_height) + 8)
          end
        end
      end
      @map.clear_enemy_data
      @map.pre_render window
      @cam.set @player.position.x, @player.position.y
      @state = :done_loading
    end

    def die
      load_level
    end

    def fade_enemies
      min_distance = 196
      @enemies.each do |e|
        distance = Vec2.distance(@player.position, e.position)
        if distance < min_distance
          e.color.alpha = LD26.qlerp(255, 0, distance / min_distance)
        else
          e.color.alpha = 0.0
        end
      end
    end

		def update dt
      if @state == :loading
      elsif @state == :done_loading
        @state = :playing
      else
			  if reached_end?
          next_level
			  end
			  @map.update dt
        @characters.each{ |c| c.update dt, @map }
        @enemies.each{ |e| e.update dt, @map }
        fade_enemies()
        if collide_enemies?
          die
          return
        end
        # spawn_rain
        @particle_manager.update dt
			  @cam.move @player.position.x, @player.position.y
        @cam.update dt
      end
		end

    def collide_enemies?
      @enemies.each do |e|
        if e.collides_with?(@player)
          return true
        end
      end
      false
    end

    def spawn_rain
      p = @particle_manager.pop()
      p.x = rand() * WIDTH * 2
      p.y = rand() * HEIGHT * 2
      p.duration = 3000 + 5000 * rand()
      p.vel_x = (-0.5 + rand()) * 0.01
      p.vel_y = (-0.5 + rand()) * 0.01
      p.scale = 0.3 + rand() * 0.5
    end

		def draw
      clear()
      if @state == :loading
        @font.draw("Loading...", WIDTH / 2.0, HEIGHT / 2.0, 0, 1.0, 1.0, Gosu::Color::BLACK)
      elsif @state == :done_loading
      else
			  @map.draw @cam
			  @cam.translate do
          ##@logo.draw(0, 0, 0)
          @particle_manager.draw
          @enemies.each do |e|
            e.draw
          end
          @characters.each do |c| 
            c.draw 
            #red = LD26.color(255, 0 ,0 ,50)
            #window.draw_quad(
            #  c.left, c.top, red,
            #  c.right, c.top, red,
            #  c.right, c.bottom, red,
            #  c.left, c.bottom, red
            #)
          end
			  end
        #@font.draw("Grounded: #{@player.grounded}", 16, 32, 0, 1.0, 1.0, Gosu::Color::BLACK)
        #@filter.draw(0, 0, 0)
      end
		end

    def clear
      window.draw_quad(
        0, 0, Gosu::Color::WHITE,
        WIDTH, 0, Gosu::Color::WHITE,
        WIDTH, HEIGHT, Gosu::Color::GRAY,
        0, HEIGHT, Gosu::Color::WHITE
      )
    end
	end
end
