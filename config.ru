# config.ru

# run Proc.new { |env| ['200', {'Content-Type' => 'text/html'}, ['get rack\'d']] }

class HelloWorld

  # hash to store redirects
  @@redirects = {
    'sf' => "http://www.suppen-fabrik.de",
    'ci' => "https://www.offen.net/muenster-no/casa-ilayda-FIDMQA/"
  }

  def call(env)
    req = Rack::Request.new(env)
    path = normalizeIndex(req.path_info.downcase)
    link = @@redirects[path]
    unless link.nil?
      [302, {"location" => link}, []]
    else
      [404, {"Content-Type" => "text/html"}, ["<br><br><br><center>
        <img src=\"https://pbs.twimg.com/profile_images/463340019839549440/iPCrcR_O_400x400.png\"><br><br><h2>404</h2>REDIRECT " + path.upcase! + " UNKOWN
        </center>"]]
    end
  end

  def normalizeIndex(path)
    paths = path.split('/')
    path = ''
    paths.each do |i|
      path = i unless i == ''
    end
    return path
  end

end

run HelloWorld.new
