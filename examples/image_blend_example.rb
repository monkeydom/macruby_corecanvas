#!/usr/bin/env macruby
HERE = File.expand_path(File.dirname(__FILE__))
require File.join(HERE, 'lib/example_helper')

dimensions = [415, 730]

ExampleHelper.example_canvas({:size => dimensions}) do |c|
	c.background(Color.white)
	c.font('Skia')
	c.font_size(14)
	# set image width,height
	w, h = [95,95]
	# set initial drawing position
	x, y = [10, c.height - h - 10]
	# load and resize two images
	img_a = Image.new(File.join(HERE, 'images', 'v2.jpg')).resize(w,h)
	img_b = Image.new(File.join(HERE, 'images', 'italy.jpg')).resize(w,h)
	
	# add image B to image A using each blending mode, and draw to canvas
	[:normal,:multiply,:screen,:overlay,:darken,:lighten,
		:colordodge,:colorburn,:softlight,:hardlight,:difference,:exclusion,
		:hue,:saturation,:color,:luminosity,:maximum,:minimum,:add,:atop,
		:in,:out,:over].each do |blendmode|
		img_a.reset.resize(w,h)
		img_a.blend(img_b, blendmode)
		c.draw(img_a,x,y)
		c.text(blendmode, x, y-15)
		x += w + 5
		if (x > c.width - w + 5)
			x = 10
			y -= h + 25
		end
	end
end
