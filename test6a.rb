require 'pry'
# 14. Inflight-entertainment

# What data structure gives us convenient constant-time lookups? - A set
# Make sure not to show same movie twice

require 'set'

# Brute Force O(n^2)

# def two_movies arr, total
#   arr.each do |first|
#     arr.each do |second|
#       return true if first + second == total
#     end
#   end
#   return false
# end

def two_movies arr, total
  seen = Set.new
  arr.each do |first|
    match = total - first
    return true if seen.include? match
    seen.add(first)
  end
  return false
end


# p two_movies [10,20,30], 60
# p two_movies [10,20,10,20,30], 30

# Complexity O(n) time and O(n) space

# Write an efficient function that takes stock_prices_yesterday and returns the best profit I could have made from 1 purchase and 1 sale of 1 Apple stock yesterday.

# A greedy algorithm iterates through the problem space taking the optimal solution "so far", until it reaches the end.

# The greedy approach is only optimal if the problem has "optimal substructures," which means stitching together optimal solutions to subproblems yields an optimal solution

# Brute Force

# 1. APPLE STOCKS

def get_max_profit arr
  max = 0
  arr.each_with_index do |x,xi|
    for later_price in arr[xi+1..-1]
      potential = later_price - x
      max = [max, potential].max
    end
  end
  return max
end

stock_prices_yesterday = [10, 7, 5, 8, 11, 9]
# p get_max_profit(stock_prices_yesterday)

# O(n^2)

def get_max_profit2 arr

  message = 'Getting a profit requires at least two prices'
  raise IndexError, message if arr.length < 2

  max_profit = arr[1] - arr[0]
  min = arr.shift

  arr.each do |x|
    potential = x - min
    max_profit = [potential, max_profit].max
    min = [x, min].min
  end

  return max_profit
end

stock_prices_yesterday = [10, 7, 5, 8, 11, 9]

# p get_max_profit2(stock_prices_yesterday)

# O(n) time and O(1) space. Loop once
# returns 6 (buying for $5 and selling for $11)

# 4. MERGE MEETING TIMES

def merge_ranges meetings
  sorted = meetings.sort
  merged = [sorted.shift]

  sorted.each do |start, exit|
    last_m_start, last_m_exit = merged[-1]

    if start <= last_m_exit
      merged[-1] = [last_m_start, [last_m_exit, exit].max]
    else
      merged.push([start, exit])
    end
  end
  return merged

end

range = [[0, 1],[3, 5],[4, 8],[10, 12],[9, 10]]  

# p merge_ranges range # [[0, 1], [3, 8], [9, 12]]

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


def pairs_given_sum num, arr
  the_hash, indices = Hash.new, []
  arr.each_with_index do |x,xi|
    complement = num - x
    lookup = the_hash[complement]
    lookup.nil? ? the_hash[x] = xi : indices << [lookup, xi]
  end
  indices
end





