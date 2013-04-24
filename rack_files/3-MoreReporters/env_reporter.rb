class EnvReporter
  def initialize(app=nil)
    @app = app
  end

  def call(env)
    output = ""
    unless @app.nil?
      response = @app.call(env)[2] 
      response.each{ |val| output += "#{val}" }
    end  
    output += "<h3>LIST OF ENVIRONMENTAL VARIABLES:</h3><ul>"
    env.keys.each{ |key| output += "<li>#{key} = #{env[key]}</li>" }
    output += "</ul>"
    output += "<p>&nbsp;</p>"
    ["200", {"Content-Type" => "text/html"}, [output]]
  end
end