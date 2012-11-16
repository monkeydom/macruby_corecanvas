# MacRuby CoreCanvas

MacRuby CoreCanvas is intended to get the excellent HotCocoa Graphics/MacRuby Graphics back up, and package it into a nice little gem to work on OS X Lion and upward.

See [HotCocoa Graphics by drtoast](http://hcg.drtoast.com)

### Design Goals

- Harness the full power of Quartz and Core Image
- make it as independent of other libraries as possible
- Keep it light and maintainable and maintain it running from OS X Lion upwards
- make it ideal for production class generative image generation

### examples
run all the examples via

	macrake examples

## Heritage
 
Inspiration for this project was derived from Processing and NodeBox.  These excellent graphics programming environments are more full-featured than MRG, but they are implemented in Java and Python, respectively.  MRG was created to offer similar functionality using the Ruby programming language.

The original author of this library is James Reynolds, MacRuby Graphics was then called Ruby Cocoa Graphics and was packaged as part of Hotcocoa. I made the choice to extract it, add more examples and specs so MacRuby developers could use this library as an addon to their projects without needing HotCocoa.

Citation from [drtoast](http://hcg.drtoast.com/standalone-library):
> A little history and an update: after Rich Kilmer integrated my graphics library into Apple's MacRuby project as part of the "HotCocoa" library, the HotCocoa project was split out from MacRuby into its own gem at github.com/richkilmer/hotcocoa. Then, Matt Aimonetti extracted the graphics library out of HotCocoa into its OWN standalone library, MacRuby Graphics. Here's my fork of that project, where future development efforts will be directed: github.com/drtoast/macruby_graphics

This post is from a year ago, so as I couldn't find any real progress happening, I [@monkeydom](http://twitter.com/monkeydom) took the liberty to fork and rename the project to fit it to my needs.
