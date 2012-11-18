#!/usr/bin/env macruby
HERE = File.expand_path(File.dirname(__FILE__))
require File.join(HERE, 'lib/example_helper')

dimensions = [400,400]

ExampleHelper.example_canvas({:size => dimensions}) do |canvas|
	canvas.background(Color.black)
	
	# create a new gradient
	gradient = Gradient.new
	
	# set the component colors of the gradient
	gradient.set(Color.black,Color.blue,Color.red.darken,Color.orange)
	
	# draw a linear gradient starting at 50,50 and ending at 200,200
	canvas.gradient(gradient, 50,50,200,200)
	
	# do not extend gradient beyond its start/endpoints
	gradient.pre(false)
	gradient.post(false)
	
	# draw a radial gradient starting at 200,200 with radius 100
	canvas.radial(gradient, 200,200,100)
end
