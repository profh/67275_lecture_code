require './models/proverb'
require 'haml'

class KcwApp
  
  def call(env)
    proverb = Proverb.new.random
    template = File.open("views/index.haml").read
    engine = Haml::Engine.new(template)
    output = engine.render(Object.new, :proverb => proverb)
    ["200", {"Content-Type" => "text/html"}, [output]]
  end
end

run KcwApp.new