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

class Client

  def get(url)
    # create the HTTP GET request
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(URI(url))

    # connect to the server and send the request
    response = http.request(request)
    response.body

    response
  end

end


class Document
  def initialize doc
    @doc = File.open(doc)
  end

  # def display
  #   occurrence.each{|k,v| puts "Word: #{k}, Freq: #{v}"}
  # end

  def parse
    @doc.map(&:split).flatten
  end

  def occurrence
    words = []
    parse.each do |word|
      words << word.gsub(/[^a-zA-Z]/, "").downcase
    end


    # words
    words.each do |x|
        pig_latin(x)
    end.join(' ')



  end
end


def pig_latin word
  vowels = %w(a e i o u)
  if vowels.include? word[0]
    word + 'yay'
  else
    vw = nil
    word.chars.each_with_index do |x,xi|
      vw = xi and break if vowels.include? x
    end
    pre = word[0...vw]
    suf = word[vw..-1]
    suf + pre + 'ay'
  end
end

doc = Document.new("word_freq.txt")

p doc.occurrence


# url = "https://www.google.com/robots.txt"
# url = "https://www.google.com/"

# pig_latin = Client.new

# doc = JSON.parse(pig_latin.get(url).body)

# p pig_latin.get(url).body


# "word_freq.txt"



