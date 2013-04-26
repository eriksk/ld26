module LD26
	class ParticleManager
		attr_accessor :count
		def initialize window, images, capacity = 512
			@window = window
			@images = images
			@particles = []
			@capacity = capacity
			@capacity.times do |i|
				@particles << Particle.new
			end
			@count = 0
		end

		def spawn_explosion x, y, count = 24
			power = 0.0
			count.times do |i|
				power = 0.5 + rand()
				p = pop()
				p.duration = 500 + rand() * 3000
				p.x = x
				p.y = y
				p.vel_x = (-0.5  + rand()) * power
				p.vel_y = (-0.5  + rand()) * power
				p.rotation = Math::atan2(p.vel_y, p.vel_x)
				p.scale = 0.5 + rand() * 0.8
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
				p.x += p.vel_x * dt
				p.y += p.vel_y * dt
				p.current += dt
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
				@images[p.source].draw(p.x, p.y, 0, p.rotation.to_degrees, p.origin_x, p.origin_y, p.scale, p.scale, p.color)
			end
		end
	end
end
