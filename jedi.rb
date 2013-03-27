module Fighting
  attr_accessor :grappling, :marksmanship, :fencing
end

module Piloting
  attr_accessor :maneuvering, :attacking, :evading
end

module TheForce
  # intelligent microscopic life forms that live symbiotically in the cells of all living things
  attr_accessor :midichlorian_level  
end

module DarkSide
  attr_accessor :hatred, :envy, :selishness, :anger
end

# ======================
class Warrior
  include Fighting
  
  @@num = 0
end

class Jedi < Warrior
  include TheForce
  # elevated midichlorians make all Jedi prescient to some degree
  attr_accessor :prescience
  
  @@num_of_jedi = 0
  
  class << self
    def count
      @@num_of_jedi
    end
  end
   
  # because the Force manifests itself in so many different ways and degrees
  def method_missing(method_name, *args)
    if method_name.to_s.match(/power_of_([\w_]+)/)
      instance_eval "@#{$1} = #{args[0]}"
      instance_eval("def #{$1}; @#{$1}; end")
    else
      super
    end
  end
  
end

class StormTrooper < Warrior
  attr_accessor :unit
end


obiwan = Jedi.new
obiwan.fencing = 17
obiwan.midichlorian_level = 150
obiwan.power_of_telekinesis 12
obiwan.power_of_hypnosis 18

yoda = Jedi.new
class << yoda
  def omniscience
    "can see the future (mostly)"
  end
end

anakin = Jedi.new
class << anakin
  include Piloting
  include DarkSide
  def chosen
    "you are the chosen one"
  end
end

puts "Obi-Wan's lightsaber technique: #{obiwan.fencing}"
puts "Obi-Wan on hypnosis: #{obiwan.hypnosis}"
puts yoda.omniscience

anakin.anger = 199
puts "Anakin's anger is #{anakin.anger} and that's pretty high"
anakin.evading = 45
puts "Anakin's ability to evade is #{anakin.evading} \nIt's okay, but he still gets into plenty of trouble"

