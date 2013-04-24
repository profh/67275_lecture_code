require './env_reporter'
require './time_reporter'

class KcwApp
  def call(env)
    ["200", {"Content-Type" => "text/html"}, ["<title>KCW App</title>","<h2>nuqneH tera'</h2>"]]
  end
end

# use TimeReporter
use EnvReporter
use TimeReporter
run KcwApp.new
