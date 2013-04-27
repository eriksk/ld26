module LD26
  class Touch
    attr_accessor :state, :alpha
    def initialize
      @alpha = 0.0
      @state = :none
    end
  end
end
