require 'rubygems'
require 'corecanvas'
include CoreCanvas

class ExampleHelper

	DefaultOptions = {:size => [400,400]}
	class << self
		def script_name
			File.basename($0, '.rb')
		end
		
		def output_dir
			here = File.expand_path(File.dirname(__FILE__))
			File.expand_path(File.join(here,"../results"))
		end
		
		def output_base
			File.join(output_dir,script_name)
		end
		
		# current options
		# :size [x, y]
		def example_canvas (options={}, &block)
			base_options = DefaultOptions.merge(options)
			
			# ensure equal randomness
			base_seed = srand()
			['.png','.pdf'].each do |ext|
				example_canvas_internal({:base_seed => base_seed, :extension => ext, :canvas_options => base_options}, &block).save
			end
			%x[open "#{ExampleHelper.output_dir}"]
		end
		
		private
		def example_canvas_internal(options, &block)
			srand(options[:base_seed])
			canvas_options = options[:canvas_options].clone
			canvas_options[:filename] = output_base + options[:extension]
			case options[:extension]
				when '.pdf'
					Canvas.for_pdf(canvas_options, &block)
				else
					Canvas.for_image(canvas_options, &block)
			end
		end	
		
	end
end