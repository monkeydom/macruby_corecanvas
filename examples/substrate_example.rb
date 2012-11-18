#!/usr/bin/env macruby
HERE = File.expand_path(File.dirname(__FILE__))
require File.join(HERE, 'lib/example_helper')

# Ported to HotCocoa::Graphics by James Reynolds 6/1/2008 from:
# Substrate Watercolor
# j.tarbell   June, 2004
# Albuquerque, New Mexico
# complexification.net

FRAMES = 310
DIMX = 200
DIMY = 200

# sand painters
COLORSIZE = 2.0
CRACKSIZE = 1.0
MAXCRACKS = 100
SANDGRAINS = 64

# color parameters
MAXPAL = 256
NUMPAL = 0
HUEDRIFT = 0.0

# grab colors
i = Image.new(File.join(HERE,'images/v2.jpg'))
GOODCOLOR = i.colors(MAXPAL)

# grid of CRACKS
CGRID = Array.new(DIMX*DIMY);
CRACKS = Array.new(MAXCRACKS);
$numcracks = 0;
C = Canvas.new :type => :image, :filename => ExampleHelper.output_base + '.png', :size => [DIMX, DIMY]
C.background(Color.white);

# METHODS --------------------------------------------------

def makeCrack()
  if ($numcracks<MAXCRACKS)
    # make a new crack instance
    CRACKS[$numcracks] = Crack.new
    $numcracks += 1
  end
end

def beginstuff
  # erase crack grid
  for y in 0...DIMY do
    for x in 0...DIMX do
      CGRID[y*DIMX+x] = 10001;
    end
  end
  # make random crack seeds
  for k in 0...16 do
    i = rand(DIMX*DIMY-1)
    CGRID[i]=rand(360)
  end

  # make just three CRACKS
  $numcracks=0;
  for k in 0...3 do
    makeCrack()
  end
  C.background(Color.white);
end

# OBJECTS -------------------------------------------------------

class Crack
	include Math
  def initialize
#    puts "Crack.new"
    # find placement along existing crack
    @sp = SandPainter.new(C)
    @sp.grains = SANDGRAINS
    @sp.grainsize = COLORSIZE
    @sp.huedrift = HUEDRIFT
    @sp.color = choose(GOODCOLOR)
    @verbose = true
    findStart();
  end

  def findStart()

    # pick random point
    px=0;
    py=0;

    # shift until crack is found
    found=false;
    timeout = 0;
    #while ((!found) && (timeout < 1000))
    while ((!found))# || (timeout > 1000))
      px = rand(DIMX)
      py = rand(DIMY)
      if (CGRID[py*DIMX+px]<10000)
        found=true;
        print "."
        STDOUT.flush
#        puts "found crack at #{px},#{py} with angle #{CGRID[py*DIMX+px]} (#{found})" if @verbose
      else
        #puts "checked #{px},#{py}" if @verbose
      end
      timeout += 1
    end

    if (found)
      # start crack
      a = CGRID[py*DIMX+px];
      if (rand(100)<50)
        a-=90+random(-2,2.1)#.to_i;
      else
        a+=90+random(-2,2.1)#.to_i;
      end
      startCrack(px,py,a);
    else
      println("timeout: "+timeout);
    end
  end

  def startCrack(x, y, t)
#    puts "starting crack at #{x},#{y} with angle #{t}" if @verbose
    @x=x;
    @y=y;
    @t=t;#%360;
    @x+=0.61*cos(@t*PI/180);
    @y+=0.61*sin(@t*PI/180);
  end

  def move()
    # continue cracking
    @x+=0.42*cos(@t*PI/180);
    @y+=0.42*sin(@t*PI/180);

    # bound check
    z = 0.33;
    cx = (@x+random(-z,z)).to_i;  # add fuzz
    cy = (@y+random(-z,z)).to_i;

    # draw sand painter
    regionColor();

    # draw black crack
    C.fill(Color.black);
    C.oval(@x+random(-z,z),@y+random(-z,z),CRACKSIZE,CRACKSIZE);

    if ((cx>=0) && (cx<DIMX) && (cy>=0) && (cy<DIMY))
      # safe to check
      if ((CGRID[cy*DIMX+cx]>10000) || (CGRID[cy*DIMX+cx]-@t).abs<5)
        # continue cracking
        CGRID[cy*DIMX+cx]=@t.to_i
      elsif ((CGRID[cy*DIMX+cx]-@t).abs>2)
        # crack encountered (not self), stop cracking
        findStart();
        makeCrack();
      end
    else
      # out of bounds, stop cracking
      findStart();
      makeCrack();
    end
  end

  def regionColor()
    # start checking one step away
    rx=@x;
    ry=@y;
    openspace=true;

    # find extents of open space
    while (openspace)
      # move perpendicular to crack
      rx+=0.81*sin(@t*PI/180);
      ry-=0.81*cos(@t*PI/180);
      cx = rx.to_i
      cy = ry.to_i
      if ((cx>=0) && (cx<DIMX) && (cy>=0) && (cy<DIMY))
        # safe to check
        if (CGRID[cy*DIMX+cx]>10000)
          # space is open
        else
          openspace=false;
        end
      else
        openspace=false;
      end
    end
    # draw sand painter
    @sp.render(@x,@y,rx,ry);
  end
  
  private
  def choose(somearray)
  	somearray[rand(somearray.size)]
  end

	def random (x,y)
		x + ((x-y) + rand())
	end

end

beginstuff

for i in 0..FRAMES do
  # crack all CRACKS
  for n in 0...$numcracks do
    CRACKS[n].move();
  end
  puts "frame #{i}, cracks: #{$numcracks}"

end

C.save