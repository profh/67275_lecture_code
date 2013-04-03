require 'ghojmoh'
# 
# # Eval is a method that evaluates a Ruby string
# p eval "3+4" # => 7
# eval "def multiply(x,y) ; x*y; end"
# # def multiply(x,y) ; x*y; end
# puts multiply(4,7) # => 28
# brk
# 
# # ===========================
# # instance_eval evaluates a string containing Ruby code or
# # a given block within context of the receiver (object)
# # class Duck
# #   def initialize
# #     @breed = "mallard"
# #    end
# # end
# 
# class Duck
#   attr_reader :name, :breed
#   
#   def initialize(name="duck", breed="regular")
#     @name = name
#     @breed = breed
#    end
#    
#    def talk(param=nil)
#      if param == "regular"
#        talk_sound = "quack"
#      elsif param == "rubber"
#        talk_sound = "squeek"
#      elsif param == "donald"
#        talk_sound = "garbled"
#      else
#        talk_sound = "none"
#      end
#      binding
#    end
#    
#    private
#    # Real ducks can't count and nor can Donald
#    def counting
#      puts "hard to do it right"
#    end
# end
# 
# # creating two duck objects to work with:
# donald = Duck.new("Donald Duck", "Cartoon") 
# mallard = Duck.new("Good Duck", "Mallard")
# 
# 
# # ===========================
# # instance_eval evaluates a string containing Ruby code or
# # a given block within context of the receiver (object)
# 
# donald.instance_eval { p @breed }   # => "Cartoon"
# mallard.instance_eval "def eat; 'duck_food'; end"
# p mallard.eat # => duck_food
# # p donald.eat
# 
# # # Can be used to define singleton class methods
# Duck.instance_eval "def talk; p 'quack'; end"
# Duck.talk # => "quack"
# # donald.talk # => undefined method `talk' for #<Duck:0x2281c @breed="Cartoon"> (NoMethodError)
# 
# Duck.instance_eval{ def walk ; p 'waddle'; end }
# Duck.walk # => "waddle"
# 
# Fixnum.instance_eval "def zero; 0 ; end"                                                 
# Fixnum.zero # => 0
# 
# Fixnum.instance_eval{ def ten ; 10; end }
# Fixnum.ten # => 10
# 
# brk
# # ===========================
# # class_eval evaluates a string containing Ruby code or
# # a given block within context of the receiver (class)
# 
# Duck.class_eval "def swim; p 'swish, swish'; end"
# mallard = Duck.new
# p mallard.talk("regular") # => "quack"
# p mallard.swim # => "swish, swish"
# 
# 
# Fixnum.class_eval "def number ; self ;end"
# 5.number # => 5
# 42.number # => 42
# 
# # This will err because the receiver is not a class
# d = Duck.new
# d.class_eval "def talk; p 'quack'; end"
# 
# 
# # # can use class_eval to access private methods dynamically
# module M; end
# # String.include M # => private method `include' called for String:Class (NoMethodError)
# String.class_eval{include M} # => works
# 
# 
# # Checking access to the private method
# # =======================
# # Normal method calling
# # donald.counting # => private method `counting' called for #<Duck:0xf4d8> (NoMethodError)
# 
# # Sending a message
# donald.send :counting   # => hard to do it right
# 
# # Instantiating a method object
# donald.method(:counting).call  # => hard to do it right
#  
# # Using eval
# # eval "donald.counting"  # => private method `counting' called for #<Duck:0xf4d8> (NoMethodError)
# 
# # Using instance_eval
# donald.instance_eval {counting} # => hard to do it right


brk
# ===========================
# Learning check: why does the following happen?  Can we explain this in light of 
# what we know about these methods and the Ruby object model?
# Foo = Class.new
# f = Foo.new
# p Foo.class
# p f.class
# smbrk
# 
# class Bar
# end
# b = Bar.new
# p Bar.class
# p b.class
# 
# Foo.class_eval do
#   def class_bar
#     p "class_bar"
#   end
# end
# 
# Foo.instance_eval do
#   def instance_bar
#     p "instance_bar"
#   end
# end
# 
# # Foo.class_bar         # class_bar , error 
# Foo.new.class_bar     # class_bar
# Foo.instance_bar      # instance_bar
# # Foo.new.instance_bar  # error 

# # # # # # # # # # # # # # # # # # # # # # # # 
# Foo.class_bar       #=> undefined method ‘class_bar’ for Foo:Class
# Foo.new.class_bar   #=> "class_bar"
# Foo.instance_bar       #=> "instance_bar"
# Foo.new.instance_bar   #=> undefined method ‘instance_bar’ for #<Foo:0x7dce8>

# brk
# ===========================
# We can use all this to make our own attr_accessor
# (call this version attr_access to be safe...)

class Class
  def attr_access(*attrs)
    p_self
    attrs.each do |attr|
      class_eval %Q{
      def #{attr} 
        @#{attr}
      end
      def #{attr}=(value)
        @#{attr} = value
      end
      }
    end
  end
end
 
class Person 
  attr_access :first_name, :last_name 
end
 
p Person.instance_methods(false) # => ["last_name", "first_name", "last_name=", "first_name="]



# REVIEW ON BINDINGS
# 
# # Binding object passed as part of talk method
# bound = donald.talk("donald") { "...not a mouse like Mickey" }
# 
# p eval("self", bound)
# p eval("@name", bound)
# p eval("@breed", bound)
# p eval("talk_sound", bound)
# p eval("param", bound)
# p eval("yield", bound)
# # reset the local variable talk_sound and see binding changed
# eval("talk_sound = 'QUACK!'", bound)
# p eval("talk_sound", bound)
