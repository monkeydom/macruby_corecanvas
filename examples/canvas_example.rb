#!/usr/bin/env macruby
require 'rubygems'
require 'corecanvas'
include CoreCanvas

HERE = File.expand_path(File.dirname(__FILE__))
#require File.join(HERE, 'lib/example_helper')
OUTPUT_DIR = File.join(HERE, "results")
SCRIPT_NAME = File.basename($0, '.rb')

def canvas_example(options={}, &block)
	default_options = {:size => [400,400]}
	base_options = default_options.merge(options)
	
	output_basename = File.join(OUTPUT_DIR, SCRIPT_NAME)
	
	base_seed = srand()
	
	srand(base_seed)
	options = base_options.clone
	options[:filename] = output_basename + '.png'
#	p options
	Canvas.for_image(options, &block).save
	
	srand(base_seed)
	options = base_options.clone
	options[:filename] = output_basename + '.pdf'
#	p options
	Canvas.for_pdf(options, &block).save
end

canvas_example do |c|
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

%x[open "#{OUTPUT_DIR}"]
