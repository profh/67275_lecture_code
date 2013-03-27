# get some object helpers
require 'ghojmoh'

# ------------------------
# Start with a simple module and class
module Fowllike
  def walk; "waddle"; end
  def swim; "paddle"; end
end

class Duck
  # include Fowllike
  def talk; "quack"; end
end
p Duck.ancestors 
brk

# ------------------------
# Three ways to invoke a method in Ruby
puts "Use the standard dot notation to call a method"

mallard = Duck.new
p mallard.talk
smbrk
puts "Can also use eval on string to call method"
p eval "mallard.talk"
eval "def mallard.fly; 'fly west, young duck'; end;"
p mallard.fly
brk
# 
puts "Use the send method to send a message to the object"
p mallard.send :talk
Duck.send :include, Fowllike
p mallard.walk
smbrk
p Duck.ancestors
brk

#
puts "Use the call method to invoke a particular method"
p mallard.method(:walk).call
# p mallard.walk
swimming = mallard.method(:swim)
3.times {print swimming.call + " "}
brk

#-------------
# Which is best?  A few benchmarks are in order:
require 'benchmark'
test = "goose" 
m = test.method(:length) 
n = 100000 
Benchmark.bmbm {|bm| 
  bm.report("reg")  { n.times { test.length } }
  bm.report("send") { n.times { test.send(:length) } }
  bm.report("call") { n.times { m.call } }  
  bm.report("eval") { n.times { eval "test.length" } } 
}
