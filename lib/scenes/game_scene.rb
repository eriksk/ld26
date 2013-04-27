module LD26
	class GameScene < Scene
		def initialize game
			super game
			@map = Tmx::Loader.load "map_1", game.window
      #@logo = window.load_image('ld_logo')
			@cam = Camera.new window
      @font = window.load_font 64
      @player = CharacterFactory.create(window, :player)
        .set_position(WIDTH / 2.0, HEIGHT / 2.0)
      @characters = []
      @characters << @player
		end

		def update dt
			if window.button_down? Gosu::KbEnter
				@game.pop_scene
			end
			@map.update dt
      @characters.each{ |c| c.update dt, @map }
			@cam.move @player.position.x, @player.position.y
      @cam.update dt
		end

		def draw
      clear()
			@map.draw @cam
			@cam.translate do
        ##@logo.draw(0, 0, 0)
        red = LD26.color(255, 0 ,0 ,50)
        @characters.each do |c| 
          c.draw 
          window.draw_quad(
            c.left, c.top, red,
            c.right, c.top, red,
            c.right, c.bottom, red,
            c.left, c.bottom, red
          )
        end
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
