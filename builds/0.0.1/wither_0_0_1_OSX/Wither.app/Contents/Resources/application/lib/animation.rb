module LD26
  class Animation
    def initialize frames, interval
      @frames = frames
      @interval = interval
      reset()
    end

    def reset
      @current = 0.0
      @current_frame = 0
    end

    def frame
      @frames[@current_frame]
    end

    def update dt
      @current += dt
      if @current > @interval 
        @current = 0.0
        @current_frame += 1
        if @current_frame > @frames.size - 1
          reset()
        end
      end
    end
  end
end
