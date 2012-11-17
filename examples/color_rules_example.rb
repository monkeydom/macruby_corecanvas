#!/usr/bin/env macruby
HERE = File.expand_path(File.dirname(__FILE__))
require File.join(HERE, 'lib/example_helper')

dimensions = [400,400]

ExampleHelper.example_canvas({:size => dimensions}) do |canvas|
	canvas.background(Color.white)
	canvas.font('Skia')
	canvas.font_size(12)
	
	# create a new color with the specified red, green, blue, and alpha values
	blue = Color.new(0.0,0.4,0.6,1.0)
	
	# draw the original color
	canvas.translate(135,350)
	canvas.text("original color",-115,10)
	canvas.fill(blue)
	canvas.rect(0,0,255,30)
	canvas.fill(Color.black)
	
	# create a rectangle to use as a color swatch
	swatch = Path.new.rect(0,0,15,30)
	swatch.increment(:x, 15)
	
	# draw harmony schemes derived from this color
	for scheme in [
		:complementary,:split_complementary,:left_complement,
		:right_complement,:monochrome,:triad,:tetrad,:compound,
		:flipped_compound
		] do
		canvas.translate(0,-38)
		canvas.text(scheme,-115,10)
		swatch.increment(:fill, blue.send(scheme).sort)
		canvas.draw(swatch,0,0,17)
	end
end

