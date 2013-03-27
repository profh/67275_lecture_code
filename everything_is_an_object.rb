# Examples: looking at classes and ancestors
5.class                 # => Fixnum
5.class.ancestors       # => [Fixnum, Integer, Numeric, Comparable, Object, Kernel, BasicObject]

"Quack".class           # => String
"Quack".class.ancestors # => [String, Comparable, Object, Kernel, BasicObject]

[1,2,3].class           # => Array
[1,2,3].class.ancestors # => [Array, Enumerable, Object, Kernel, BasicObject]

d = class Duck; self; end;
daffy = Duck.new
d.class                 # => Class
d.class.ancestors       # => [Class, Module, Object, Kernel, BasicObject]
daffy.class             # => Duck
daffy.class.ancestors   # => [Duck, Object, Kernel, BasicObject]


# Object receive messages
"quack".send :upcase    # => "QUACK"
5.send :+, 9            # => 14
[1,2,3].send :nil?      # => false
d.send :class           # => Class
daffy.send :class       # => Duck


######################################
### Example of the pen and the scribe
  # create a pen object
  pen = Object.new      # => #<Object:0x007f8f3c0ca378>

  # add a method to the pen
  def pen.to_s          # !> previous definition of to_s existed and we are overwriting it
    "A trusty pen"
  end
  # see that this method works as expected
  pen.send :to_s        # => "A trusty pen"
  pen.to_s              # => "A trusty pen"
  pen                   # => A trusty pen (the to_s method served as the object's name now)
  
  # pen.write "nunqeh Terran" # => NoMethodError: undefined method `write' for A trusty pen:Object
  
  def pen.write(words)
    Kernel.puts words
  end
  
  pen.write "nunqeh Terran" 
  ## => nil >> nunqeh Terran
  pen.write pen             
  ## => nil >> A trusty pen

  # let's make the pen a blue ink pen (b/c blue is an awesome color...)
  # pen.ink_color = "Blue"  # => NoMethodError: undefined method `ink_color' for A trusty pen:Object
  
  # okay, let's define the method ink_color for the pen object
  def pen.ink_color= color
    @ink_color = color
  end
  
  # now set the color to blue
  pen.ink_color = "Blue"    # => "Blue"
  
  # let's update to_s to add in the color
  def pen.to_s              # !> method redefined; discarding old to_s
    "A trusty #{@ink_color.downcase} pen" 
  end
  
  # verify that it works
  pen.send :to_s            # => "A trusty blue pen"

  # writing a method that adds 'sparkles' to words to demo implicit receivers
  def pen.sparkly_write words
    write "*;. #{words} *;.*" # note the implicit receiver
  end

  pen.sparkly_write "Sparkles! (sort of)"  
  ## => nil >> *;. Sparkles! (sort of) *;.*
  pen.sparkly_write pen                    
  ## => nil >> *;. A trusty blue pen *;.*

  # create a method to write html
  def pen.html_write words
    if @ink_color
      write "<p style=\"color: #{@ink_color};\">#{words}</p>"
      # sorry for adding the color style right in the p tag but a good demo otherwise...
    else
      write "<p>#{words}</p>"
    end 
  end
  
  # now try this method out...
  pen.html_write "Sorry for the style class" 
  ## => nil >> <p style="color: Blue;">Sorry for the style class</p>
  
  # create a scribe class to use the pen
  # use alt notation for creating class to make connection with Object
  Scribe = Class.new do
    def initialize pen
      @pen = pen
      @items = Array.new
    end
    
    def note item
      @items << item
    end
    
    def write_everything
      @items.each{ |item| @pen.write item }
    end
  end
  
  # one of the most famous scribes in the OT was Ezra, so ...
  ezra = Scribe.new pen
  ezra.note "The time is #{Time.now}"
  ezra.note "Time to read the Law to the people"
  ezra.write_everything
  # >> The time is 2013-03-20 08:37:03 -0400
  # >> Time to read the Law to the people
