# In Insertion Sort Part 1, you sorted one element into an array. Using the same approach repeatedly, can you sort an entire unsorted array?

# Guideline: You already can place an element into a sorted array. How can you use that code to build up a sorted array, one element at a time? Note that in the first step, when you consider an element with just the first element - that is already "sorted" since there's nothing to its left that is smaller.

# In this challenge, don't print every time you move an element. Instead, print the array after each iteration of the insertion-sort, i.e., whenever the next element is placed at its correct position.

# Since the array composed of just the first element is already "sorted", begin printing from the second element and on.

# Time complexity O(n^2)
# =================================================================================

def insertion_sort arr
  for x in (1...arr.size)
    i = arr[x]
    j = x -1
    while j >= 0 and arr[j] > i
      arr[j+1] = arr[j]
      j-=1
    end
    arr[j+1] = i
  end
  p arr
end

# insertion_sort [1,4,3,5,6,2]
# insertion_sort [1,4,3,7,6,2]

# Watson gives Sherlock an array AA of length NN. Then he asks him to determine if there exists an element in the array such that the sum of the elements on its left is equal to the sum of the elements on its right. If there are no elements to the left/right, then the sum is considered to be zero. 
# Formally, find an ii, such that, AA1+A+A2...A...Ai-1 =A=Ai+1+A+Ai+2...A...AN.
# =================================================================================

def sherlock_array arr
  left, right = 0, arr.reduce(:+)
  equi_index = false
  arr.each_with_index do |x,xi|
    right -= x
    equi_index = true and break if left == right 
    left += x
  end
  puts equi_index ? 'YES' : 'NO'
end

# sherlock_array [1,2,3] # NO
# sherlock_array [1,2,3,3] # YES

# Sunny and Johnny together have MM dollars they want to spend on ice cream. The parlor offers NN flavors, and they want to choose two flavors so that they end up spending the whole amount.

# You are given the cost of these flavors. The cost of the iithth flavor is denoted by ccii. You have to display the indices of the two flavors whose sum is MM.
# =================================================================================

def ice_cream_parlor num, arr
  for i in (0...arr.size)
    for j in (i+1...arr.size)
      indices = [i, j] and break if arr[i] + arr[j] == num
    end
  end
  p indices
end

# ice_cream_parlor 4, [1,4,5,3,2]
# ice_cream_parlor 4, [2,2,4,3]

# Time complexity O(N) using Kadane's algorithm 

# Because of the way this algorithm uses optimal substructures (the maximum subarray ending at each position is calculated in a simple way from a related but smaller and overlapping subproblem: the maximum subarray ending at the previous position) this algorithm can be viewed as a simple example of dynamic programming.

# Kadane's algorithm consists of a scan through the array values, computing at each position the maximum (positive sum) subarray ending at that position. This subarray is either empty (in which case its sum is zero) or consists of one more element than the maximum subarray ending at the previous position. The algorithm only needs to keep track of the ending position because the implied starting position is just after the last position the sum went negative, and you can always get a higher sum by dropping any negative-sum prefix. 
# Kadane's Algo - look at each index and figure out max sum subarray ending at this index. 
# =================================================================================

def the_max_subarray arr
  max_so_far = max_cur = arr.shift
  arr.each do |x|
    max_cur = [x, max_cur + x].max
    max_so_far = [max_cur, max_so_far].max
  end
  puts max_so_far
end

# the_max_subarray [-4,5,5,-7,4,-1,8,-6]  # 14
# the_max_subarray [-1,-2,-3,-4,-5, -6]  # -1
# the_max_subarray [1] # 1
# the_max_subarray [1,2,3,4] # 10
# the_max_subarray [2,-1,2,3,4,-5] # 10
# the_max_subarray [31, -41, 59, 26, -53, 58, 97, -93, -23, 84] # 187 

# Maximum Sum Subarray 
# - Brute Force - Time Complexity O(N^2)
# - Kadane's Algo = Time Complexity O(N^2) - divide and conquer method
#  -- but can do much better with Kadane! - can run at linear time O(N)
# - local max subarray is either the current element or current element combined with the previous subarray
# - use this method for every element except for first element

# When I ask these kinds of question, the answer isn't necessarily the goal. The goal is to see how they break down a problem. The main thing I personally look for is:
# 1) identify a brute strength algorithm
# 2) identify that #1 is a brute strength approach
# 3) can they identify any parameters which can limit the problem's scope
# 4) can they improve their #1
# For #3 in this problem the limiting parameter is that the empty set will have a sum of 0 and thus is the case to beat.

# ======== Count the number of negative numbers row wise and column wise ===========
# Worst case time complexity is O(N*M) - n is the #of rows, m is the #of columns.
# Optimal = starting from last element in row find first negative number and record its position = now you know that all to the left is negative. - Time complexity is O(N+M) - n = rows, m = columns
# =================================================================================

def count_neg_num grid
  count = 0
  size = grid[0].size
  grid.each_with_index do |x,xi|
    x.reverse.each_with_index do |y,yi|
      count += size - yi and break if y < 0
    end
  end
  puts count
end

grid = [[-3,-2,-1,1],
        [-2,2,3,4],
        [4,5,7,8]]

count_neg_num grid
# 7 vs 12 Naive solution O(N*M) vs Optimal solution O(N+M)

