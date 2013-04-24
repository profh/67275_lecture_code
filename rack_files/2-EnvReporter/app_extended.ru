class EnvReporter

  def initialize(app=nil)
    # Allow for another app to be passed in
    @app = app
  end

  def call(env)
    # Set up basic output string
    output = ""
    
    unless @app.nil?
      # if there is an app being passed in, use it's call method and 
      # get the response (third item in the response array) of the app
      response = @app.call(env)[2] 
      response.each{ |val| output += "#{val}" }
    end
    
    # Add the information about each env var to output string
    output += "<h3>LIST OF ENVIRONMENTAL VARIABLES:</h3><ul>"
    env.keys.each{ |key| output += "<li>#{key} = #{env[key]}</li>" }
    output += "</ul>"
    
    # Return the formatted output
    ["200", {"Content-Type" => "text/html"}, [output]]
  end
end

run EnvReporter.new
