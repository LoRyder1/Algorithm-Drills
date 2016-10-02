require 'webrick'
require 'webrick/httpproxy'
require 'cgi'
require 'uri'
require 'net/http'
require 'net/https'
require 'json'
require 'pry'
require 'open-uri'
require 'nokogiri'



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
  attr_reader :words, :uri, :converted, :parsed
  def initialize uri
    @uri = uri
    @parsed = nil
    @words = []
    @converted = []
  end

  def parse
    @parsed = @uri.read.split(' ').flatten
    # @parsed = open(uri).map(&:split).flatten
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


newuri = URI::HTTP.build({:host => 'lovinderpnag.com', :path => '/word_freq.txt'})

# p newuri.methods

# p newuri.open.meta["content-type"] == "text/plain; charset=utf-8"
# 
# uri = "http://localhost:8080/host=techcrunch.com"
uri = "http://localhost:8080/word_freq.txt?host=techcrunch.com"

# open("http://" + site + "/" + params["host"][0]) do |content|
#   doc = Nokogiri::HTML(content)


uri = "https://techcrunch.com"

# open(uri) do |content|
#   doc = Nokogiri::HTML(content)
#   doc.traverse do |x|
#     if x.text?
#       x.content = "hello"
#     end
#   end
#   res.body = doc.to_html
# end




# req = CGI.parse(uri)
# 
# p req.methods
# p req.request_uri
# p req.path
# p req.query

req = URI.parse(uri)

if req.query.nil?
  params = CGI.parse(req.path)
  new_uri = URI::HTTP.build({host: params["/host"][0]})
  p new_uri
else
  params = CGI::parse(req.query)
  new_uri = URI::HTTP.build({host: params["host"][0], path: req.path})
  p new_uri
end

# p req.query
# p req.methods


# p req.params
# p uri.query

# if req.path.nil? == true
#   p req
# end


# p new_uri
# p CGI.parse(new_uri.request_uri)


# netfile = NetFile.new(newuri)
# netfile.parse
# p netfile.uri.read
# p netfile.parsed

# netfile.filter
# p netfile.words
# netfile.convert_to_pig_latin

# p netfile.converted.join(' ')


# p "\\nWASHINGTON Unable to rest their eyes".split(/\s|\\n/).join(" ")
# p "\\nWASHINGTON Unable to rest their eyes".split(" ").join(" ")

# p "\nWASHINGTON Unable to rest their eyes"

# ?.,'!







