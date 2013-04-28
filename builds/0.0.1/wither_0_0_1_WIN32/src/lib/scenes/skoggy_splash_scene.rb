module LD26
	class SkoggySplashScene < Scene
		def initialize game
			super game
			@current = 0.0
			@duration = 3000
      @wither = Text.new(window, 64, "wither")
        .set_position(WIDTH * 0.5, HEIGHT * 0.5)
      @wither.color.alpha = 0
      @skoggy = Text.new(window, 24, "by Skoggy")
        .set_position(WIDTH * 0.5, HEIGHT * 0.55)
      @skoggy.color.alpha = 0
      @state = :fade_in
		end

		def update dt
			@current += dt

      case @state
      when :fade_in
        @wither.color.alpha = LD26.lerp(0, 255, @current / @duration)
        @skoggy.color.alpha = LD26.qlerp(0, 255, @current / @duration)
        if @current > @duration
          @current = 0.0
          @state = :fade_out
        end
      when :fade_out
        @wither.color.alpha = LD26.lerp(255, 0, @current / @duration)
        @skoggy.color.alpha = LD26.qlerp(255, 0, @current / @duration)
			  if @current > @duration
          goto_next_scene
			  end
      end

			if (!window.button_down?(Gosu::KbSpace) & @space_down)
        goto_next_scene
			end
			@space_down = window.button_down?(Gosu::KbSpace)
		end

    def goto_next_scene
				@game.pop_scene
				@game.push_scene GameScene.new @game
    end

		def draw
      @wither.draw
      @skoggy.draw
		end
	end
end
