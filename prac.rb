# def stair_case num
#   (1..num).each do |x|
#     spaces = num - x
#     puts " "*spaces + "#"*x
#   end

# end

# # p stair_case 6

# # t = gets.strip.to_i

# # for x in (1..t)
# #     n = gets.strip
# #     arr = gets.strip.split(' ').map(&:to_i)
    
# #   pos = []
# #   arr.each{ |x| pos << x if x > 0 }
# #   pos_sum = pos.reduce(:+)

# #   max_ending_here = max_so_far = arr.shift
# #   arr.each do |x|
# #     max_ending_here = [x, max_ending_here + x].max
# #     max_so_far = [max_so_far, max_ending_here].max
# #   end

# #   if pos.empty?
# #     puts "#{max_so_far} #{max_so_far}"
# #   else
# #     puts "#{max_so_far} #{pos_sum}"
# #   end
    
# # end


# def max_subarray3 arr
#   arr.reduce([0,0]) do |(max_so_far, max_up_to_here), x|
#     new_max_up_to_here = [max_up_to_here + x, 0].max
#     new_max_so_far = [max_so_far, new_max_up_to_here].max
#     [new_max_so_far, new_max_up_to_here]
#   end.first
# end

# # xs = [31, -41, 59, 26, -53, 58, 97, -93, -23, 84]
# # p max_subarray2(xs) #=> 187
# # p max_subarray2 [-1 -2 -3 -4 -5 -6]  # -1

# # p max_subarray3(xs) #=> 187

def max_subarray( arr )
  max = 0
  # choose a starting point in the array
  (0..arr.length-1).each do |start|
    result = 0
    # loop forward through array elements
    (start..arr.length-1).each do |num|
      result += arr[num]
      max = result if result > max
    end
  end
  puts max
end

def the_max_subarray arr
  max_so_far = max_cur = arr.shift
  arr.each do |x|
    max_cur = [x,max_cur+x].max
    max_so_far = [max_cur, max_so_far].max
  end
  max_so_far
end


def maxLength a, b
  arr = []
  for i in 1..(a.length) do
    arr += a.combination(i).to_a
    p arr
  end
  arr.reject! do |x|
    x.reduce(:+) > b
  end.last.size
end


# [1,2], [2,3], [1,2,3]

p maxLength [1,2,3], 3
p maxLength [3,1,2,1], 4






