module LD26
	def self.color r = 255, g = 255, b = 255, a = 255
		clr = Gosu::Color.new
		clr.red = r
		clr.green = g
		clr.blue = b
		clr.alpha = a
		clr
	end

	# linear interpolation
	def self.lerp x, y, w
		x + (y - x) * w
	end
	
	# cubic interpolation using a hermite spline, aka smooth step
	def self.qlerp(min, max, weight)
		hermite(min, 0.0, max, 0.0, weight)
	end
	
	# value1, tangent1, value2, tangent2
	def self.hermite(v1, t1, v2, t2, weight)
		sCubed = weight * weight * weight
		sSquared = weight * weight
		result = 0.0
		if weight == 0.0
			result = v1
		elsif weight == 1.0
			result = v2
		else
		result = (2 * v1 - 2 * v2 + t2 + t1) * sCubed + (3 * v2 - 3 * v1 - 2 * t1 - t2) * sSquared + t1 * weight + v1
	end
result
end

  def self.clamp(value, min, max)
    if value < min
      return min
    elsif value > max
      return max
    end
    value
  end
	
end

class Numeric
	def to_degrees
		self * 180.0 / Math::PI
	end
end
