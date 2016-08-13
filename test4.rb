# ============ NUMS TO COMMAS   ============

def separate_with_commas num
  num.to_s.reverse.split('').each_slice(3).map(&:join).join(',').reverse
end

# p separate_with_commas 1000
# p separate_with_commas 10000

# nums = [100,1000,10000,100000,1000000,100000000,1000000000,10000000000,100000000000]

# nums.each do |x|
#   p separate_with_commas(x)
# end

# ============ PAD ARRAY ====================

class Array
  def pad num, obj=nil
    rep = num - self.size    
    rep.times{ self.push(obj) }
    self
  end
end

# p [1,2,3].pad(5)
# p [1,2,3].pad(5, 'apple')

# =============== Fibonacci Sequence =========================

def is_fibonacci? num
  fib_seq = [0,1]
  while num > fib_seq.last
    x,y = fib_seq.pop(2)
    fib_seq.push(x,y,x+y)
  end
  fib_seq.include? num  
end

# p is_fibonacci? 33
# p is_fibonacci? 34

def fibonacci_recursive n
  return n if n < 2
  fibonacci_recursive(n-1) + fibonacci_recursive(n-2)
end

# p fibonacci_recursive 15 # 610

# 1. DRIVER TESTS GO BELOW THIS LINE

def random_fibonacci
  [0,1,1,2,3,5,8,13,21,34,55,89,144,233,377,610,987,1597,2584,4181,6765,10946].sample
end

def assert 
  raise "Assert Failed!" unless yield
end

# assert {is_fibonacci?(random_fibonacci) == true }
# assert {is_fibonacci?(random_fibonacci) == true }
# assert {is_fibonacci?(random_fibonacci) == true }
# assert {is_fibonacci?(8670007398507948658051921) == true}
# assert {is_fibonacci?(random_fibonacci+100) == false}
# assert {is_fibonacci?(927372692193078999171) == false}

# ============ NUM to WORDS ==================

NUM_WORDS = {
  90 => "ninty",
  50 => "fifty",
  40 => "fourty",
  30 => "thirty",
  20 => "twenty",
  11 => "eleven",
  10 => "ten",
  9 => "nine",
  8 => "eight",
  7 => "seven",
  6 => "six",
  5 => "five",
  4 => "four",
  3 => "three",
  2 => "two",
  1 => "one"
}

def in_words num
  num_string = ''
  NUM_WORDS.each do |k,v|
    num_string += v*(num/k)
    num %= k
  end
  num_string
end

# p in_words 4         # => "four"
# p in_words 5         # => "five"
# p in_words 27       # => "twenty seven"

# ============ Factorial ==================

# 5! = 5 * 4 * 3 * 2 * 1
# 6! = 6 * 5 * 4 * 3 * 2 * 1

def factorial n
  arr = []
  while n >= 1
    arr.push n
    n -=1
  end
  arr.reduce(:*)
end

# p factorial 4  # 24

def factorial_recursive n
  return 1 if n == 0
  n * factorial_recursive(n-1)
end

# p factorial_recursive 4


# ============ PRIME NUMBERS ==================

#  prime number can only be divided by itself and 1

def is_prime? n
  x = n -1
  while x > 1
    return false if (n % x).zero?
    x -= 1
  end
  true
end

# p is_prime? 3 # true
# p is_prime? 5 # true
# p is_prime? 9 # false
# p is_prime? 1481 # true
# p is_prime? 7253 # true

def factors n
  1.upto(Math.sqrt(n)).select{ |x| (n % x).zero?}.inject([]) do |arr,x|
    arr << x
    arr << n/x unless x == n/x
    arr.sort
  end
end

# p factors 81
# p factors 50
# p factors 9

# ============ ANAGRAM ==================

def is_anagram? a,b
  canonical(a) == canonical(b)
end

def canonical word
  word.downcase.split('').sort.join  
end

# p is_anagram?('cinema', 'iceman')

dictionary = ['acres', 'cares', 'Cesar', 'races', 'smelt', 'melts', 'etlsm', 'shazam']

def anagrams_for word, dictionary
  anagrams = []
  dictionary.each do |x|
    anagrams << x if is_anagram? word, x
  end
  anagrams
end

# p anagrams_for 'smelt', dictionary
# p anagrams_for 'acres', dictionary


# GET a word from user input.
# IF the word starts with a vowel, don't change it.
# ELSE replace the word with its pig latin equivalent.
#   GET all of the consonants before the first vowel in the word.
#   SET the consonants at the end of the word and add the suffix "ay."
# ENDIF
# PRINT the pig-latin-ified word.


# ============ PIG LATIN =====================

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

# p pig_latin 'acre'  # acreyay
# p pig_latin 'pig' # 'igpay'
# p pig_latin 'trash' # 'ashtray'


# p convert_sentence("acre pig trash")

# ============ Roman Numerals Kata ===============

# Feature 1 - Converting Arabic to Roman

ROMAN_NUMBERS = { 1000 => "M",
                  900 => "CM",
                  500 => "D",
                  400 => "CD",
                  100 => "C",
                  50 => "L",
                  40 => "XL",
                  10 => "X",
                  9 => "IX",
                  5 => "V",
                  4 => "IV",
                  1 => "I" }

def to_roman num
  roman = ''
  ROMAN_NUMBERS.each do |key,value|
    roman += value*(num/key)
    num %= key
  end
  roman
end

# p to_roman 1983
# p to_roman 4
# p to_roman 58

# Feature 2 - Converting Roman to Arabic

def to_arabic num
  arabic = 0
  ROMAN_NUMBERS.each do |key, value|
    while num.start_with? value
      arabic += key
      num = num.slice(value.size, num.size)
    end
  end
  arabic
end

# p to_arabic "MCMLXXXIII"
# p to_arabic "IV"
