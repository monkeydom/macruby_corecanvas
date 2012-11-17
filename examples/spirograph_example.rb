#!/usr/bin/env macruby
HERE = File.expand_path(File.dirname(__FILE__))
require File.join(HERE, 'lib/example_helper')

dimensions = [400,400]

ExampleHelper.example_canvas({:size => dimensions}) do |c|
	c.background(Color.beige)
	c.fill(Color.black)
	c.font('Book Antiqua')
	c.font_size(12)
	c.translate(200,200)

	# rotate, draw text, repeat
	180.times do |frame|
		c.new_state do
			c.rotate((frame*2) + 120)
			c.translate(70,0)
			c.text('going...', 80, 0)
			c.rotate(frame * 6)
			c.text('Around and', 20, 0)
		end
	end
end
