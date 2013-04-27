module LD26
  class AudioManager

    def initialize window
      @window = window
      @song = window.load_song("song1")
    end
    
    def play
      @song.play true
    end

    def stop
      @song.stop
    end
  end
end
