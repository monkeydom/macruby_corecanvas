task :default => :build
task :build   => :gem

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs << 'test'
end

require 'rubygems/package_task'
spec = Gem::Specification.load('corecanvas.gemspec')
Gem::PackageTask.new(spec) { }

desc 'Run all examples'
task :examples do
	puts "examples\n"
	Dir.glob('examples/**/*.rb').each do |example|
		puts example
		%x[macruby -Ilib "#{example}"]
	end
end