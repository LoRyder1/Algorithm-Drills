# Pig Latin Proxy

# Write an HTTP proxy server that translates all the pages it proxies into Pig Latin! This server should only accept get requests, and should return a version of each page requested where all the English has been converted into Pig Latin. (This involves moving all the consonants at the start of the string to the end and adding "ay" to it.)

# The host to which the request should be proxied should should be specified in a query param. For example, if your proxy is running on localhost, port 8080, a request through the proxy for

# http://www.nytimes.com/robots.txt

# would look like

# https://localhost:8080/robots.txt?host=www.nytimes.com

# After you have this working with text files (like robots.txt), make it work for HTML pages. This will require parsing the HTML and only rewriting content (not HTML tags or JavaScript). Re-write links to point to the proxied versions of linked pages, so that you can browse the web in Pig Latin.

require 'uri'
require 'net/http'
require 'net/https'
require 'json'
require 'pry'
require 'open-uri'
# require 'httparty'

# class Request
#   attr_reader :url, :uri_host, :uri_path
#   def initialize url
#     @url = url
#     @uri_host = uri_host
#     @uri_path = uri_path
#   end

#   def get
#     # create the HTTP GET request
#     uri = URI.parse(@url)
#     @uri_host = uri.host
#     @uri_path = uri.path

#     http = Net::HTTP.new(uri.host, uri.port)
#     http.use_ssl = true
#     http.verify_mode = OpenSSL::SSL::VERIFY_NONE
#     request = Net::HTTP::Get.new(URI(url))

#     # connect to the server and send the request
#     response = http.request(request)
#     response
#   end

# end


# start with converting a text file to pig latin

require 'pry'
require 'pp'

def pig_latin word
  vowels = %w(a e i o u)
  if vowels.include? word[0]
    word + 'yay'
  else
    vw = nil
    word.chars.each_with_index do |x,xi|
      vw = xi and break if vowels.include? x
    end
    vw = word.index('y') if vw.nil?
    return word if vw.nil?
    pre = word[0...vw]
    suf = word[vw..-1]
    suf + pre + 'ay'
  end
end

class NetFile
  attr_reader :words, :address, :converted
  def initialize address
    @address = address
    @parsed = nil
    @words = []
    @converted = []
  end

  def parse
    @parsed = open(address).map(&:split).flatten
  end

  def filter
    @parsed.each do |word|
      if /\d+/.match(word).nil? == false
        @words << word
        next
      end
      @words << word.downcase.gsub(/[^a-zA-Z]/, "")
    end
  end

  def convert_to_pig_latin
    @words.each do |word|
      @converted << pig_latin(word)
    end
    @converted.join(' ')
  end

end

# http proxy server that translate pages its receives
# netfile = NetFile.new('http://lovinderpnag.com/word_freq.txt')
# netfile.parse
# netfile.filter
# netfile.words
# netfile.convert_to_pig_latin
# p netfile.converted.join(' ')



require 'webrick'
require 'webrick/httpproxy'

# handler = proc do |req, res|
#   if res['content-type'].include? 'text/plain' then
#     res.body << "\nThis content was proxied!\n"
#   end
#   p res.body
# end

# proxy = WEBrick::HTTPProxyServer.new Port: 8000, ProxyContentHandler: handler
proxy = WEBrick::HTTPProxyServer.new Port: 8000


proxy.mount_proc '/' do |req, res|
  x = 'robots.txt?host=nytimes.com'
  res.body = 'Hello, world!'
end




trap 'INT'  do proxy.shutdown end
trap 'TERM' do proxy.shutdown end

proxy.start
