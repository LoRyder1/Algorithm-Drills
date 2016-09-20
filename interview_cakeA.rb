# 28. Parenthesis Matching
# Find the closing parenthesis

def get_closing_paren sentence, opening_paren_index
  open_nested_parens = 0

  (opening_paren_index + 1).upto(sentence.length - 1) do |position|
    char = sentence[position]

    if char == '('
      open_nested_parens += 1
    elsif char == ')'
      if open_nested_parens == 0
        return position
      else
        open_nested_parens -= 1
      end
    end
  end

  raise Exception, "No closing parenthesis :("
end

# p get_closing_paren "(sdajljfas)jdfs.", 0

# Complexity: O(n) time, where n is the number of chars in the string. O(1) space

require 'set'

def is_valid code
  openers_to_closers_hash = {
    '(' => ')',
    '{' => '}',
    '[' => ']'
  }

  openers = Set.new(openers_to_closers_hash.keys)
  closers = Set.new(openers_to_closers_hash.values)

  openers_stack = []

  for i in 0...code.length
    char = code[i]
    if openers.include? char
      openers_stack.push(char)
    elsif closers.include? char
      if openers_stack.empty?
        return false
      else
        last_unclosed_opener = openers_stack.pop

        # if this closer doesn't correspond to the most recently
        # seen unclosed opener, short-circuit, returning false
        if openers_to_closers_hash[last_unclosed_opener] != char
          return false
        end

      end
    end
  end
  return openers_stack == []
end

# p is_valid("(ahfds)")

# Complexity: O(n) time (one iteration through the string), and O(n) space

# Two common uses for stacks are:
# 1. parsing 
# 2. tree or graph traversal


# ====== find a Pair in array that add up to 100 ============

# def pairs_given_sum sum, arr
#   indices = []
#   for i in (0...arr.size)
#     for j in (i+1...arr.size)
#       indices << [i,j] if arr[i] + arr[j] == sum
#     end
#   end
#   indices
# end

# Here you go, an excuse for me to play a bit with Ruby and an excuse for you to learn it:

def find2sum(array,desired_sum)
  the_hash=Hash.new
  i=0
  array.each do |elt|
    complement = desired_sum-elt
    lookup = the_hash[complement]
    if (lookup == nil)
      the_hash[elt]=i
    else
      #puts "soln found, complement=#{complement} at index=#{lookup}, with #{elt} at #{i}"
      return [lookup,i]
    end
    i=i+1
  end
  #puts "soln not found!"
  return[-1,-1]
end

# p find2sum [1,2,3,4,5], 6


def pairs_given_sum num, arr
  the_hash, i , indices = Hash.new, 0, []
  arr.each do |x|
    complement = num - x
    lookup = the_hash[complement]
    lookup.nil? ? the_hash[x] = i : indices << [lookup, i]
    i += 1
    # puts the_hash
  end
  indices
end

def pairs_given_sum 
  
end

p pairs_given_sum 100, [1,50,2,98,0,100,50,99,23,95]
