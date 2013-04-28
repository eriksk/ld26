module LD26
	class ParticleManager
		attr_accessor :count
		def initialize images, capacity = 1024
			@images = images
			@particles = []
			@capacity = capacity
			@capacity.times do |i|
				@particles << Particle.new
			end
			@count = 0
		end

		def spawn_explosion x, y, count = 24, pwr = 1.0
			power = 0.0
			count.times do |i|
				power = (0.5 + rand()) * pwr
				p = pop()
				p.duration = 500 + rand() * 3000
				p.x = x
				p.y = y
        p.rotation = rand() * 10.0
				p.vel_x = Math::cos(p.rotation) * power
				p.vel_y = Math::sin(p.rotation) * power
				p.scale = 0.3 + rand() * 0.7
			end
		end

		def pop
			p = @particles[@count]
			@count += 1
			p.current = 0.0
			p
		end

		def push index
			temp = @particles[@count - 1]
			@particles[@count - 1] = @particles[index]
			@particles[index] = temp
			@count -= 1
		end

		def update dt
			# custom loop for decrementation while running
			i = 0
			while i < @count
				p = @particles[i]
				p.x += LD26.lerp(p.vel_x, 0.0, p.current / p.duration)
				p.y += LD26.lerp(p.vel_y, 0.0, p.current / p.duration)
				p.current += dt
        p.color.alpha = LD26.lerp(255, 0 , p.current / p.duration)
				if p.current > p.duration
					push i
					i -= 1
				end
				i += 1
			end
		end

		def draw
			@count.times do |i|
				p = @particles[i]
				@images[p.source].draw_rot(p.x, p.y, 0, p.rotation.to_degrees, p.origin_x, p.origin_y, p.scale, p.scale, p.color)
			end
		end
	end
end
