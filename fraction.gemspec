spec = Gem::Specification.new do |s|
	s.name = 'fraction'
	s.authors = ["Christopher Lord", "David Eppstein", "Arno Formella"] 
	s.email = "christopherlord+fractiongem@gmail.com"
	s.homepage = "http://christopher.lord.ac"
	s.version = '0.1'
	s.summary = 'Provides a "fraction" method on all ruby floats.'
	s.description = 'Provides a "fraction" method on all ruby floats.'
	s.extensions << 'extconf.rb'
	s.files = 'fraction.c' 
end
