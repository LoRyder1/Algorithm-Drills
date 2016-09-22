# 28. Parenthesis Matching
# Find the closing parenthesis

def get_closing_paren sent, index
  open = 0
  sent.chars.each_with_index do |x,xi|
    if xi > index
      if x == '('
        open +=1
      elsif x == ')'
        if open.zero? 
          return xi
        else
          open -= 1
        end
      end
    end
  end
  raise Exception, "No closing parenthesis :("
end

# p get_closing_paren "(sdajljfas)jdfs.", 0

# Complexity: O(n) time, where n is the number of chars in the string. O(1) space

# 29. Bracket Validator

# Write a brackets validator
# A greedy algorithm iterates through the problem space taking the optimal soluiton "so far," until it reaches the end. The greedy approach is only optimal if the problem has "optimal substructure," which means stiching together optimal solutions to subproblems yields an optimal solution. 

require 'set'

def is_valid sent
  hash = { '(' => ')', '{' => '}', '[' => ']'}

  openers, closers = Set.new(hash.keys), Set.new(hash.values)

  openers_stack = []

  sent.chars.each_with_index do |x,xi|
    if openers.include? x
      openers_stack.push x
    elsif closers.include? x
      if openers_stack.empty? 
        return false
      else
        last_enclosed_opener = openers_stack.pop
        if hash[last_enclosed_opener] != x
          return false
        end
      end
    end
  end
  return openers_stack.empty? 
end

p is_valid "(ahfds)"

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

# p find2sum [1,2,3,4,5], 6

def pairs_given_sum num, arr
  the_hash, indices = Hash.new, []
  arr.each_with_index do |x,xi|
    complement = num - x
    lookup = the_hash[complement]
    lookup.nil? ? the_hash[x] = xi : indices << [lookup, xi]
    # puts the_hash
  end
  indices
end

p pairs_given_sum 100, [1,50,2,98,0,100,50,99,23,95] #[[2, 3], [4, 5], [1, 6], [0, 7]]


