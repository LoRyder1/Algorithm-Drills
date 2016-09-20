
class Document
  def initialize doc
    @doc = File.open(doc)
  end

  def display
    occurrence.each{|k,v| puts "Word: #{k}, Freq: #{v}"}
  end

  def parse
    @doc.map(&:split).flatten
  end

  def occurrence
    freq = Hash.new(0)
    parse.each do |word|
      new_word = word.gsub(/[^a-zA-Z]/, "").downcase
      freq.store(new_word, freq[new_word]+1)
    end
    Hash[freq.sort_by{|k,v| v}.reverse]
  end
end




# ====== Driver Code=====

doc = Document.new('word_freq.txt')

# p doc.parse
# p doc.occurrence
# doc.display