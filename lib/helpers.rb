module LD26
	def self.color r = 255, g = 255, b = 255, a = 255
		clr = Gosu::Color.new
		clr.red = r
		clr.green = g
		clr.blue = b
		clr.alpha = a
		clr
	end
end

class Numeric
	def to_degrees
		self * 180.0 / Math::PI
	end
end
