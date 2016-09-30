class Document
  def initialize(doc)
    @doc = File.open(doc)
  end
  
  def display
    occurrence.each do |x,y|
      puts "#{x}: #{y}"
    end
  end

  # private
  def parse
    @doc.map(&:split).flatten
  end

  def occurrence
    frequency = Hash.new(0)
    parse.each do |word|
      new_word = word.gsub(/[^a-zA-Z]/, "").downcase
      frequency.store(new_word, frequency[new_word]+1)
    end
    Hash[frequency.sort_by{|k,v| v}.reverse]
  end
end

#==== Driver Code ==========

doc = Document.new('word_freq.txt')
# p doc.parse
p doc.occurence
 # doc.display
# p doc.words

