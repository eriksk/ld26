module LD26
  class Touch
    attr_accessor :col, :row, :color
    def initialize col, row
      @col, @row = col, row
      @color = LD26.color()
    end
  end
end
