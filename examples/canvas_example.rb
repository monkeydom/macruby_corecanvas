#!/usr/bin/env macruby
HERE = File.expand_path(File.dirname(__FILE__))
require File.join(HERE, 'lib/example_helper')

ExampleHelper.example_canvas do |c|
	c.background(Color.black)
	white = Color.white
	c.fill(white)
	c.stroke(0.2)
	c.stroke_width(1)   
	c.font("Zapfino")

	80.times do 
		c.font_size rand(170)
		c.fill(white.copy.darken(rand(0.8)))
		letters = %W{ g i a n a } 
		c.text(letters[rand(letters.size)],
						rand(c.width),
						rand(c.height))
	end
end
