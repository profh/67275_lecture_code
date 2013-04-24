require './kcw_framework'

class KcwApp < KcwFramework
  def initialize
    # get("home", :proverb => Proverb.new.random)
    get("index", :proverbs => Proverb.new.all)
  end
end

run KcwApp.new