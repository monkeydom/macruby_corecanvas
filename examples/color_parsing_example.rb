#!/usr/bin/env macruby
HERE = File.expand_path(File.dirname(__FILE__))
require File.join(HERE, 'lib/example_helper')

dimensions = [400,400]

ExampleHelper.example_canvas({:size => dimensions}) do |canvas|
	canvas.background(Color.black)
	canvas.shadow
	
	# load an image and select 100 random colors
	image = Image.new('images/italy.jpg')
	randomcolors = image.colors(100)
	
	# create a 20x20 square at 0,0
	square = Path.new.rect(0,0,20,20,:center)
	
	# randomize the color, scale, and rotation of the square
	square.randomize(:fill, randomcolors)
	square.randomize(:scale, 1.0..5.0)
	square.randomize(:rotation, 0..360)
	
	# draw 100 squares and the original image
	canvas.grid(square,10,10)
	image.fit(120,120)
	canvas.draw(image)
end
