#==== Pangrams are sentences constructed from every letter from alpha====


# p pangram "We promptly judged antique ivory buckles for the next prize" # true

# ==== minimum number of deletions for alternating character string ====


# p alternating_char 'AAAA'   #  3
# p alternating_char 'BBBBB'  #  4
# p alternating_char 'ABABABAB' #  0
# p alternating_char 'BABABA'  #  0
# p alternating_char 'AAABBB' #  4

#=== count number of letter changes to get a palindrome by stepping back in alpha ===
# palindrome is a word that reads the same forwards and backwards 



# p love_letter 'abc'   #  2
# p love_letter 'abcba' #  0
# p love_letter 'abcd'  #  4
# p love_letter 'cba'   #  2

#=== a gem element is an occurence in each string ===



# a = ['abcdde','baccd','eeabg']

# p gem_element a   # 2

# ==is string funny? funny = xi.ord - (xi-1).ord ===



# funny('acxz') # == 'Funny'
# funny 'bcxz' # == 'Not Funny'

# ===anagram is word that is formed by rearranging the letters of another===
# figure how many changes to make anagram of second string, if can not be made anagram -> -1



x = ['aaabbb','ab','abc','mnop','xyyx','xaxbbbxx']

# x.each do |x|
#   anagram x    # 3,1,-1,2,0,1
# end

# ====palindrome is a word that reads the same forwards and backwards===




x = ['aaab', 'baa', 'aaa', 'aaba']

# x.each do |y|
#   palindrome_index y     # 3,0,-1,1 
# end

#==== is string b a substring of string a? =====

def two_strings a,b
  substring = false
  b.chars.each do |x|
    if a.chars.include? x
      substring = true
      break
    end
  end
  puts substring ? 'YES' : 'NO'  
end

# two_strings 'hello', 'world' # 'YES'
# two_strings 'hi', 'world' # 'NO'

#==== can any anagram of string be a palindrome? =====

def game_of_thrones string
  count, freq = 0, Hash.new(0)
  string.chars.each{|x| freq[x]+=1}
  freq.each do |k,v|
    count +=1 if v.odd?
  end
  puts count < 2 ? 'YES' : 'NO'  
end

# game_of_thrones 'aaabbbb' # 'YES'
# game_of_thrones 'cdefghmnopqrstuvw' # 'NO'

#=== anagram is a word that can be formed by rearranging letters from another ===
# How many deletions to make strings anagrams of each other?

def make_anagram a,b
  count, freq = 0, Hash.new(0)
  a.chars.each{ |x| freq[x]+=1 }
  b.chars.each{ |letter| freq[letter]-=1 }
  freq.each{|k,v| count+=v.abs}
  puts count
end

# make_anagram 'cde', 'abc' # 4

#=== Find the equilibrium index ====
# Time complexity O(N^2)

def equi_index arr
  left, right = 0, arr.reduce(:+)
  indices = []
  arr.each_with_index do |x,xi|
    right -= x
    indices << xi if left == right
    left += x
  end
  indices.empty? ? -1 : indices.first
end

# p equi_index [-1,3,-4,5,1,-6,2,1] # 1, 3, 7
# p equi_index [1,2,3]
# p equi_index [1082132608, 0, 1082132608]
# p equi_index [1, 2, -3, 0]

# ==== Given a group of sentences, give count of words of largest sent. ===

def largest_sent paragraph
  sent_length = []
  paragraph.split(/\?|\.|\!/).map{|x| x.split(' ')}.each{|x| sent_length << x.size}
  sent_length.max
end

p largest_sent "We test coders. Give us a try?"
p largest_sent "We test coders? Give us a try."
p largest_sent "We test's coders. Give us a try?"
p largest_sent "Forget  CVs..Save time . x x"


# ====== Caesar Cipher ==========
 # ==== encrypt string by rotating every letter in string by a fixed
# number, K, making it unreadable by his enemies. Given a string S, and a number, K, encrypt S and print the resulting string. 

def caesar_cipher string

end

p caesar_cipher 'middle-Outz'
