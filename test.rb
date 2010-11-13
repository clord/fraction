require 'rubygems'
require 'fraction'

#pure version of fraction.gem
class Float
	def ruby_fraction maxden = 10
		return [self, 1.0, 0.0] unless self && self.kind_of?(Float)
		m11 = m22 = 1
		m12 = m21 = 0
		x = self
		while m21 * (ai = x.to_i) + m22 <= maxden
			m12, m11 = [m11, (m11 * ai + m12).to_i]
			m22, m21 = [m21, (m21 * ai + m22).to_i]
			break if x == ai
			break if (x - ai).abs  < 0.000000000001
			x = 1.0 / (x - ai)
		end
		return [m11, m21, self - m11.to_f/m21.to_f]
	end
end

# Google for "ruby fraction" and you find this code
class Float
  def number_decimal_places
    self.to_s.length-2
  end
  def to_fraction
    higher = 10**self.number_decimal_places
    lower = self*higher
    gcden = greatest_common_divisor(higher, lower)
    return (lower/gcden).round, (higher/gcden).round
  end
private
  def greatest_common_divisor(a, b)
     while a%b != 0
       a,b = b.round,(a%b).round
     end 
     return b
  end
end
# make sure everything is up and running in cache with no startup delay
10_000.times {}
n,d=0.333.to_fraction
n,d=0.333.ruby_fraction
n,d=0.333.fraction


starttime = Time.now
1_000_000.times do 
  n,d=0.333.to_fraction
end
endtime = Time.now
feeling_lucky=endtime-starttime
puts "I'm Feeling Lucky:          " + feeling_lucky.to_s + "s"


starttime = Time.now
1_000_000.times do 
  n,d=0.333.ruby_fraction
end
endtime = Time.now
fractionmod=endtime-starttime
puts "pure version of fraction: " + fractionmod.to_s + "s"

starttime = Time.now
1_000_000.times do 
  n,d=0.333.fraction
end
endtime = Time.now
fractionmod=endtime-starttime
puts "C version of fraction: " + fractionmod.to_s + "s"

starttime = Time.now
1_000_000.times do 
  n,d=[1,2]
end
endtime = Time.now
max_speed=endtime-starttime
n,d=(fractionmod-max_speed).fraction
puts "just running the loop requires #{max_speed.fraction[0]}/#{max_speed.fraction[1]} of a second,"
puts "so the algorithm itself requires only #{n}/#{d} of a second"
