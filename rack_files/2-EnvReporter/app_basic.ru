class EnvReporter

  def call(env)
    # Set up basic output string
    output = "<h3>LIST OF ENVIRONMENTAL VARIABLES:</h3>"
    output += "<ul>"
    
    # Add the information about each env var to output string
    env.keys.each{ |key| output += "<li>#{key} = #{env[key]}</li>" }
    output += "</ul>"
    
    # Return the formatted output
    ["200", {"Content-Type" => "text/html"}, [output]]
  end
end

run EnvReporter.new