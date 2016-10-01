require 'nokogiri'
require 'open-uri'
require 'cgi'
require 'uri'
require 'webrick'

proxy =  WEBrick::HTTPServer.new Port: 8080

proxy.mount_proc '/' do |req, res|
  uri = URI.parse(req.unparsed_uri)
  params = CGI.parse(uri.query)
  site = req.path_info
  site[0] = ""
  open("http://" + site + "/" + params["host"][0]) do |content|
    doc = Nokogiri::HTML(content)
    doc.traverse do |x|
      if x.text?
        contents = ''
        x.content.scan(/(\w+)(\W+)/) do |alpha,nonalpha|
          first_letter = alpha.slice!(0)
          alpha += first_letter + "ay"
          contents += alpha
          p alpha + "non"+nonalpha
          contents += nonalpha
        end
        x.content = contents
      end
    end
    res.body = doc.to_html
  end
end

trap 'INT'  do proxy.shutdown end
trap 'TERM' do proxy.shutdown end

proxy.start