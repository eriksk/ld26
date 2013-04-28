module LD26
  class GameOverScene < Scene
    def initialize game
      super game
      @thank_you = Text.new(window, 64, "Thank you for playing wither")
        .set_position(WIDTH * 0.5, HEIGHT * 0.5)
      @thank_you.color.alpha = 0
      @text = Text.new(window, 24, "A Ludum Dare #26 entry by Erik Skoglund (Skoggy)")
        .set_position(WIDTH * 0.5, HEIGHT * 0.58)
      @text.color.alpha = 0
      @current = 0.0
      @duration = 5000
      @state = :fade_in
    end

    def update dt
      @current += dt
      case @state
      when :fade_in
        @thank_you.color.alpha = LD26.lerp(0, 255, @current / @duration)
        @text.color.alpha = LD26.qlerp(0, 255, @current / @duration)
        if @current > @duration
          @current = 0.0
          @state = :fade_out
        end
      when :fade_out
        @thank_you.color.alpha = LD26.lerp(255, 0, @current / @duration)
        @text.color.alpha = LD26.qlerp(255, 0, @current / @duration)
        if @current > @duration
          @game.pop_scene
        end
      end
    end

    def draw
      @thank_you.draw
      @text.draw
    end
  end
end
