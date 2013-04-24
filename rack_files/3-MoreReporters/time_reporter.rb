class TimeReporter
  def initialize(app=nil)
    @app = app
  end

  def call(env)
    output = ""
    unless @app.nil?
      response = @app.call(env)[2] 
      response.each{ |val| output += "#{val}" }
    end 
    time = Time.now
    output += "<h3>Information on Current Time and Date:</h3>"
    output += "<p>Time: #{time.strftime('%I:%M %P')}</p>"
    output += "<p>Date: #{time.strftime('%B %e, %Y')}</p>"
    output += "<p>Weekday: #{time.strftime('%A')}</p>"
    output += "<p>Time Zone: #{time.strftime('%Z')}</p>"
    output += "<p>&nbsp;</p>"
    ["200", {"Content-Type" => "text/html"}, [output]]
  end
end