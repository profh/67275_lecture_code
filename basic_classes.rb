# get some object helpers
require 'ghojmoh'

class Simple
  def talk
    puts "simple talking"
  end
end

puts Simple.superclass    # => Object
puts Simple.object_id     # => 59640
p_self                    # => main  (main is self at the top level)
Simple.p_self             # => Simple
Simple.p_eign             # => #<Class:Simple>
smbrk

simon = Simple.new      
simon.class               # => Simple
puts simon.object_id      # => 59530
simon.talk                # => "simple talking"
simon.p_self              # => #<Simple:0x007fa6e9177e00>
simon.p_eign              # => #<Class:#<Simple:0x007fa6e9177e00>>

brk

# =================

fowl = "duck"
puts fowl.class

def fowl.talk
  puts "quack!"
end 

fowl.talk

fowl2 = "goose"
#fowl2.talk
brk

# =================

duckling = Class.new
puts duckling

Ugly = duckling
puts duckling
brk


# =================
# What is self?

puts "before class, self is #{self}"
class Duck
  puts "inside class, self is #{self}"
  
  def talk
    puts "inside instance method, self is #{self}"
    puts "quack!"
  end
end
puts "after class, self is #{self}"

d = Duck.new
puts "after class instance created, self is #{self}"
d.talk
puts "after class instance, self is #{self}"
puts
smbrk
puts d.eigenclass
d.p_self
d.p_eign
Duck.p_self
Duck.p_eign
puts Duck.eigenclass
brk

# =================
# Messing around with method_missing

class Duck
  def walk
    puts "waddle"
  end
  
  def talk
    puts "quack"
  end
  
  def method_missing(name, *args, &block)
    puts "The behavior #{name} is not yet defined for ducks"
    args.each { |a| puts "not sure what to do with the argument #{a}" } unless args.nil?
    yield if block
  end
    
end

d = Duck.new
d.talk
d.walk
d.eat
d.fly "fast"
smbrk
d.swim { %w[Mallard Wood Rubber].each{|d| puts "Can a #{d} swim?"}}
