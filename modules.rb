require 'ghojmoh'

module Fighting
  attr_accessor :grappling, :marksmanship, :fencing
end

module Piloting
  attr_accessor :maneuvering, :attacking, :evading
end

module TheForce
  # intelligent microscopic life forms that live symbiotically in the cells of all living things;
  # The jedi have these in much higher concentrations than normal beings
  attr_accessor :midichlorian_level  
  
end

module DarkSide
  attr_accessor :hatred, :envy, :selishness, :anger
end


# ======================

# class Jedi
Jedi = Class.new do
  include Fighting
  include TheForce
  def initialize(name)
    @name = name
  end
  attr_reader :name
end

# two instances of Jedi
yoda = Jedi.new('Yoda')
anakin = Jedi.new('Anakin')

# review
Jedi.class            # => Class
Jedi.eigenclass       # => #<Class:Jedi>
Jedi.superclass       # => Object
Jedi.ancestors        # => [Jedi, TheForce, Fighting, Object, Ghojmoh, Kernel, BasicObject]
# yoda.ancestors        # => undefined method `ancestors' for #<Jedi:0x007f8783c0e3f8 @name="Yoda"> (NoMethodError)

yoda.midichlorian_level = 'high'
anakin.midichlorian_level = 'off the charts'
p "Yoda's midichlorian_level is #{yoda.midichlorian_level}, but Anakin's are #{anakin.midichlorian_level}"


class << anakin
  include DarkSide
end
# ~> -:1:in `<main>': undefined local variable or method `anakin' for main:Object (NameError)


anakin.send :public_methods, false # => 

# Test this...
anakin.anger = 97
anakin.anger            # => 97

# No anger in Yoda
# yoda.anger = 0        # => undefined method `anger=' for #<Jedi:0x007fb46aad3240 @name="Yoda"> (NoMethodError)


# anakin.class          # => Jedi
# anakin.eigenclass     # => #<Class:#<Jedi:0x007f9a89318dc0>>
# anakin.superclass   # => undefined method `superclass' for #<Jedi:0x007ffa3223f9b8 @name="Anakin"> (NoMethodError)
# anakin.eigenclass.superclass # => Jedi


# Problem using modules to define class methods

module Council
  def self.advise; 'good advice'; end
  # def advise; 'good advice from the Jedi'; end
end


class Jedi
  # using version with def self.advise
  include Council
end

# p Jedi.advise  # => undefined method `advise' for Jedi:Class (NoMethodError)

class Jedi
  # using version with def advise
  extend Council
  
  # alternatively
  # class << self
  #   include Council
  # end
end

p Jedi.advise

