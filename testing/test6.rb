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
          open -=1
        end
      end
    end
  end
  raise Exception, "No closing parenthesis :("
end


# Complexity: O(n) time, where n is the number of chars in the string. O(1) space

# 29. Bracket Validator

# Write a brackets validator
# A greedy algorithm iterates through the problem space taking the optimal soluiton "so far," until it reaches the end. The greedy approach is only optimal if the problem has "optimal substructure," which means stiching together optimal solutions to subproblems yields an optimal solution. 

require 'set'

def is_valid code
  hash = { '(' => ')', '{' => '}', '[' => ']' }

  openers, closers = Set.new(hash.keys), Set.new(hash.values)

  openers_stack = []

  code.chars.each_with_index do |x,xi|
    if openers.include? x
      openers_stack.push x
    elsif closers.include? x
      if openers_stack.empty? 
        return false
      else
        last_unclosed_opener = openers_stack.pop
        if hash[last_unclosed_opener] != x
          return false
        end
      end
    end
  end
  return openers_stack.empty?
end

# p is_valid("(ahfds)")

# Complexity: O(n) time (one iteration through the string), and O(n) space

# Two common uses for stacks are:
# 1. parsing 
# 2. tree or graph traversal

# write a function to reverse a string in-place
# An in-place algorithm operates directly on its input and changes it, instead of creating and returning and new object. This is sometimes called destructive, since the original input is destroyed when it's edited to create the new output. 

def reverse string
  left, right = 0, string.length - 1
  while left < right
    # swap characters
    string[left], string[right] = string[right], string[left]
    # move towards middle
    left += 1
    right -= 1
  end
  return string
end

# p reverse "hello"

# Complexity: O(n) time and O(1) space

# 27. Reverse Words


def reverse_characters message, a, z
  while a < z
    message[a], message[z] = message[z], message[a]
    a += 1
    z -= 1
  end
  return message
end

def reverse_words message

  # first we reverse all the characters in the entire message
  reverse_characters(message, 0, message.length-1)
  # this gives us the right word order
  # but with each word backwards

  # now we'll make the words forward again
  # by reversing each word's characters

  # we hold the index of the /start/ of the current word
  # as we look for the /end/ of the current word
  current_word_start_index = 0

  for i in 0..message.length
    if (message[i] == ' ') || (i == message.length)
      reverse_characters(message, current_word_start_index, i-1)
      current_word_start_index = i + 1
    end
  end

  # message.split(' ').each do |x|
  #   reverse_characters(x, 0, x.length-1)
  # end.join(' ')

  return message
end

message = "find you will pain only go you recordings security the into if"

# returns 'if into the security recordings you go only pain will you find'

p reverse_words message

# 13. Find Rotation Point

words = [
    'ptolemaic',
    'retrograde',
    'supplant',
    'undulate',
    'xenoepist',
    'asymptote', # <-- rotates here !
    'babka',
    'banoffee',
    'engender',
    'karpatka',
    'othellolagkage'
]

# words = [
#   'k', 'v', 'a', 'b', 'c', 'd', 'e', 'g', 'i'
# ]
# Binary search - common algorithm that takes advantage of the fact that a set is sorted to find an item efficiently. 

def find_rotation_point words
  first_word = words[0]

  floor_index = 0
  ceiling_index = words.length - 1

  while floor_index < ceiling_index
    distance = ceiling_index - floor_index
    half_distance = distance / 2
    guess_index = floor_index + half_distance

    if words[guess_index] > first_word
      floor_index = guess_index
    else
      ceiling_index = guess_index
    end

    if floor_index + 1 == ceiling_index
      return ceiling_index
    end

  end
end

# p find_rotation_point words

# Complexity: O(lg n) time and O(1) space, just like binary search
# We are assuming that our word lengths are bound by some constant - if they were bounded by a non-constant l, each of our string comparisons would cost O(l), for a total of O(l), for a total of O(l*lg n) runtime.

# Binary search teaches us that when an array is sorted or mostly sorted:

# 1. the value at a given index tells us a lot about what's to the left and what's to the right.
# 2. We don't have to look at every item in the array. By inspecting the middle item, we can 'rule out' half of the array.
# 3. We can use this approach over and over, cutting the problem in half until we have the answer. This is sometimes called 'divide and conquer'.


# 14. Inflight-entertainment

# What data structure gives us convenient constant-time lookups? - A set

require 'set'

def can_two_movies_fill_flight movie_lengths, flight_length

  movie_lengths_seen = Set.new

  movie_lengths.each do |first_movie_length|

    matching_second_movie_length = flight_length - first_movie_length
    if movie_lengths_seen.include? matching_second_movie_length
      return true
    end

    movie_lengths_seen.add(first_movie_length)
  end

  # we never found a match, so return false
  return false
end

# Write an efficient function that takes stock_prices_yesterday and returns the best profit I could have made from 1 purchase and 1 sale of 1 Apple stock yesterday.

# A greedy algorithm iterates through the problem space taking the optimal solution "so far", until it reaches the end.

# The greedy approach is only optimal if the problem has "optimal substructures," which means stitching together optimal solutions to subproblems yields an optimal solution

# Brute Force

# 1. APPLE STOCKS

def get_max_profit stock_prices_yesterday
  max_profit = 0
  stock_prices_yesterday.each_with_index do |earlier_price, earlier_time|
    for later_price in stock_prices_yesterday[earlier_time+1..-1]
      potential_profit = later_price - earlier_price
      max_profit = [max_profit, potential_profit].max
    end
  end
  return max_profit
end

# O(n^2)

def get_max_profit stock_prices_yesterday
  if stock_prices_yesterday.length < 2
    raise IndexError, 'Getting a profit requires at least two prices'
  end

  max_profit = stock_prices_yesterday[1] - stock_prices_yesterday[0]
  min_price = stock_prices_yesterday.shift

  stock_prices_yesterday.each do |current_price|
    potential_profit = current_price - min_price
    max_profit = [potential_profit, max_profit].max
    min_price = [current_price, min_price].min
  end

  return max_profit
end

# stock_prices_yesterday = [10, 7, 5, 8, 11, 9]

# p get_max_profit(stock_prices_yesterday)

# O(n) time and O(1) space. Loop once
# returns 6 (buying for $5 and selling for $11)

def get_products_of_all_int_except_at_index int_array
  prods_except_at_index = []
  i = int_array.length-1
  product_so_far = 1

  0.upto(i) do |x|
    prods_except_at_index << product_so_far
    product_so_far *= int_array[x]
  end

  product_so_far = 1
  
  (i).downto(0) do |x|
    prods_except_at_index[x] *= product_so_far
    product_so_far *= int_array[x]
  end

  return prods_except_at_index
end


# p get_products_of_all_int_except_at_index [1,7,3,4]
# p get_products_of_all_int_except_at_index [2,7,3,4]
# O(n) time and O(n) space

# sorting = O(n lg n)

# 4. MERGE MEETING TIMES

def merge_ranges meetings
  sorted_meetings = meetings.sort
  merged_meetings = [sorted_meetings.shift]

  sorted_meetings.each do |current_meeting_start, current_meeting_end|

    last_merged_meeting_start, last_merged_meeting_end = merged_meetings[-1]

    if current_meeting_start <= last_merged_meeting_end
      merged_meetings[-1] = [last_merged_meeting_start, [last_merged_meeting_end, current_meeting_end].max]
    else
      merged_meetings.push([current_meeting_start, current_meeting_end])
    end
  end

  return merged_meetings
end

range = [[0, 1],[3, 5],[4, 8],[10, 12],[9, 10]]  # [[0, 1], [3, 8], [9, 12]]
# p merge_ranges range

# Runtime of O(nlgn) if unordered space cost: O(n)

# memoize - memoization ensures that a function doesn't run for the same inputs more than once by keeping a record of the results for given inputs (usually in a hash).
# Memoization is a common strategy for dynamic programming problems, which are problems where the solution is composed of solutions to the same problem with smaller inputs. Another common strategy is going bottom-up

# bottom-up is a way to avoid recursion, saving the memory cost that recursion incurs when it builds up the call stack

# 5. MAKING CHANGE

def change_possibilities_bottom_up amount, denominations
  ways_of_doing_n_cents = [0] * (amount + 1)
  ways_of_doing_n_cents[0] = 1

  denominations.each do |coin|
    (coin..amount).each do |higher_amount|
      higher_amount_remainder = higher_amount - coin
      ways_of_doing_n_cents[higher_amount] += ways_of_doing_n_cents[higher_amount_remainder]
    end
  end

  return ways_of_doing_n_cents[amount]
end

# p change_possibilities_bottom_up 5, [1,3,5]
# p change_possibilities_bottom_up 6, [1,3,5]

# Complexity: O(n*m) and O(n) additional space, where n is the amount of money and m is the number of potential denominations.


# 31. Recursive String Permutations
# Write a recursive function for generating all permutations of an input string. Return them as a set.
require 'set'

def get_permutations string

  # base case
  if string.length <= 1
    return Set.new [string]
  end

  all_chars_except_last = string[0..-2]
  last_char = string[-1]

  # recursive call: get all possible permutations for all chars except last
  permutations_of_all_chars_except_last = get_permutations(all_chars_except_last)

  # put the last char in all possible positions for each of the above permutations
  permutations = Set.new
  permutations_of_all_chars_except_last.each do |permutations_of_all_chars_except_last|
    (0..all_chars_except_last.length).each do |position|
      permutation = permutations_of_all_chars_except_last[0...position] + last_char + permutations_of_all_chars_except_last[position..-1]
      permutations.add(permutation)
    end
  end

  return permutations
end

# p get_permutations 'cat'

# 32. Top Scores
# counting is a common pattern in time-saving algorithms. It can often get you O(n) runtime, but at the expense of adding O(n) space.

# The idea is to define a hash or array (call it e.g. counts) where the keys/indices represent the items from the input set and the values represent the number of times the item appears. In one pass through the input you can fully populate counts:
# counts = {}
# the_array.each do |item|
#   if counts.include? item
#     counts[item] += 1
#   else
#     counts[item] = 1
#   end
# end

def sort_scores unordered_scores, highest_possible_score
  # array of 0s at indices 0..highest_possible_score
  scores_to_counts = [0] * (highest_possible_score+1)

  # populate scores_to_counts
  unordered_scores.each do |score|
    scores_to_counts[score] += 1
  end

  # populate the final sorted array
  sorted_scores = []

  # for each item in scores_to_counts
  scores_to_counts.each_with_index do |count, score|

    # for the number of times the item occurs
    (0...count).each do |time|

      # add it to the sorted array
      sorted_scores.push(score)
    end
  end

  return sorted_scores
end

# Complexity: O(n) time and O(n) space, where n is the number of scores
# The highest_possible_score as a constant, we could call it k and say we have O(n + k) time and O(n + k) space. 

# 40. Find Repeat, Space Edition

# Write a function which finds any integer that appears more than once in our array. 

require 'set'

def find_repeat(numbers)
  numbers_seen = Set.new
  numbers.each do |number|
    if numbers_seen.include? number
      return number
    else
      numbers_seen.add(number)
    end
  end

  # whoops -- no duplicate
  raise Exception, 'no duplicate!'
end

# O(n) time and O(n) space

def find_repeat_brute_force numbers
  (1...numbers.length).each do |needle|
    has_been_seen = false
    numbers.each do |number|
      if number == needle
        if has_been_seen
          return number
        else
          has_been_seen = true
        end
      end
    end
  end
  
  # whoops--no duplicate
  raise Exception, 'no duplicate!'
end




# ================================================






# 14. Inflight-entertainment

# What data structure gives us convenient constant-time lookups? - A set

require 'set'

# Brute Force O(n^2)
def two_movies arr, total
  arr.each do |first|
    arr.each do |second|
      return true if first + second == total
    end
  end
  return false
end

def two_movies arr, total
  seen = Set.new
  arr.each do |first|
    match = total - first
    return true if seen.include? match
    seen.add(first)
  end
  return false
end

p two_movies [10,20,30], 40
p two_movies [10,20,10,20,30], 30

# Complexity O(n) time and O(n) space

# Write an efficient function that takes stock_prices_yesterday and returns the best profit I could have made from 1 purchase and 1 sale of 1 Apple stock yesterday.

# A greedy algorithm iterates through the problem space taking the optimal solution "so far", until it reaches the end.

# The greedy approach is only optimal if the problem has "optimal substructures," which means stitching together optimal solutions to subproblems yields an optimal solution

# Brute Force

# 1. APPLE STOCKS

def get_max_profit stock_prices_yesterday
  max_profit = 0
  stock_prices_yesterday.each_with_index do |earlier_price, earlier_time|
    for later_price in stock_prices_yesterday[earlier_time+1..-1]
      potential_profit = later_price - earlier_price
      max_profit = [max_profit, potential_profit].max
    end
  end
  return max_profit
end

# O(n^2)

def get_max_profit stock_prices_yesterday
  if stock_prices_yesterday.length < 2
    raise IndexError, 'Getting a profit requires at least two prices'
  end

  max_profit = stock_prices_yesterday[1] - stock_prices_yesterday[0]
  min_price = stock_prices_yesterday.shift

  stock_prices_yesterday.each do |current_price|
    potential_profit = current_price - min_price
    max_profit = [potential_profit, max_profit].max
    min_price = [current_price, min_price].min
  end

  return max_profit
end

# stock_prices_yesterday = [10, 7, 5, 8, 11, 9]

# p get_max_profit(stock_prices_yesterday)

# O(n) time and O(1) space. Loop once
# returns 6 (buying for $5 and selling for $11)

# 4. MERGE MEETING TIMES

def merge_ranges meetings
  sorted_meetings = meetings.sort
  merged_meetings = [sorted_meetings.shift]

  sorted_meetings.each do |current_meeting_start, current_meeting_end|

    last_merged_meeting_start, last_merged_meeting_end = merged_meetings[-1]

    if current_meeting_start <= last_merged_meeting_end
      merged_meetings[-1] = [last_merged_meeting_start, [last_merged_meeting_end, current_meeting_end].max]
    else
      merged_meetings.push([current_meeting_start, current_meeting_end])
    end
  end

  return merged_meetings
end

range = [[0, 1],[3, 5],[4, 8],[10, 12],[9, 10]]  # [[0, 1], [3, 8], [9, 12]]
# p merge_ranges range

# Runtime of O(nlgn) if unordered space cost: O(n)

# memoize - memoization ensures that a function doesn't run for the same inputs more than once by keeping a record of the results for given inputs (usually in a hash).
# Memoization is a common strategy for dynamic programming problems, which are problems where the solution is composed of solutions to the same problem with smaller inputs. Another common strategy is going bottom-up

# bottom-up is a way to avoid recursion, saving the memory cost that recursion incurs when it builds up the call stack

require 'set'

def find_repeat(numbers)
  numbers_seen = Set.new
  numbers.each do |number|
    if numbers_seen.include? number
      return number
    else
      numbers_seen.add(number)
    end
  end

  # whoops -- no duplicate
  raise Exception, 'no duplicate!'
end

# O(n) time and O(n) space

def find_repeat_brute_force numbers
  (1...numbers.length).each do |needle|
    has_been_seen = false
    numbers.each do |number|
      if number == needle
        if has_been_seen
          return number
        else
          has_been_seen = true
        end
      end
    end
  end
  
  # whoops--no duplicate
  raise Exception, 'no duplicate!'
end

