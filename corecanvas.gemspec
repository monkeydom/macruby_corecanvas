require './lib/corecanvas/version'

Gem::Specification.new do |s|
	s.name        = 'corecanvas'
	s.version     = CoreCanvas::VERSION
	s.date        = '2012-11-14'
	s.summary     = 'Graphics Generation Library bridging OS X CoreGraphics for MacRuby'
	s.description = 'CoreCanvas is a MacRuby library for generating Bitmap and PDF files using all of the Grahpics Libraries of OS X (Quartz, CoreImage, etc)'
	s.authors     = ['Dominik Wagner', 'Rich Kilmer', 'Matt Aimonetti', 'James Reynolds']
	s.homepage    = 'http://github.com/monkeydom/macruby_corecanvas'
	s.licenses    = ['MIT']
	s.files       =
		['Rakefile'] +
		Dir.glob('lib/**/*.rb')

	s.extra_rdoc_files =
		['README.md'] +
		Dir.glob('docs/**/*.md')

end
