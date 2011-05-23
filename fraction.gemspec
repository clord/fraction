spec = Gem::Specification.new do |s|
	s.name = 'fraction'
	s.authors = ["Christopher Lord", "David Eppstein", "Arno Formella"]
	s.email = "christopherlord+fractiongem@gmail.com"
	s.homepage = "https://github.com/clord/fraction"
	s.version = '0.3'
	s.summary = 'Provides a "to_fraction" method on all ruby floats.'
	s.description = 'Provides "to_fraction" and to_whole_fraction methods on all ruby floats and numerics.'
	s.extensions << 'extconf.rb'
	s.files = %w(fraction.c README.md)
end
