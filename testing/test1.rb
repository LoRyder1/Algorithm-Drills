# ====Cancel class if fewer than x students show up ====

def angry_prof num, arr
  ontime = 0
  arr.each{|x| ontime+=1 if x <= 0}
  puts ontime < num ? 'YES' : 'NO'
end

# angry_prof 3, [-1, -3, 4, 2] # Yes cancel class
# angry_prof 2, [0, -1, 2, 1] # No don't cancel class

# ==== Find the Decent Num =====
# Its digits can only be 3's and/or 5's.
# The number of 3's it contains is divisible by 5.
# The number of 5's it contains is divisible by 3.
# If there are more than one such number, we pick the largest one.

def decent_num num
  posib = []

  posib << "5"*num if (num%3).zero?
  posib << "3"*num if (num%5).zero?

  for threes in (1..num)
    fives = num - threes
    if (threes%5).zero? and (fives%3).zero?
      posib << "5"*fives + "3"*threes
      break
    end
  end

  puts posib.empty? ? -1 : posib.max

end

# decent_num 1   #   -1
# decent_num 3   #  555
# decent_num 5   #  33333
# decent_num 11   #  55555533333

# ======== Utopian Tree =========
# two cycles of growth in year = spring doubles in height, summer increase = +1, starting height = 1

def utopian_tree cycles
  height = 1
  for season in (1..cycles)
    season.odd? ? height*=2 : height +=1
  end
  p height
end

# utopian_tree 0 # 1
# utopian_tree 1 # 2
# utopian_tree 4 # 7

# === Find Digits ===
# Given an integer, how many digits of integer can evenly divide integer

def find_digits num
  count, digits = 0, num.to_s.split('').map(&:to_i).reject{|x| x < 1}
  digits.each{ |d| count+=1 if (num%d).zero? }
  p count
end

# find_digits 12
# find_digits 1012
# find_digits 1041

# ===Count all the squares in a given range ===

def squares a,b
  a = 0 if a < 0
  if b < 0
    puts 0
  else
    s1 = Math.sqrt(a).ceil
    s2 = Math.sqrt(b).floor
    puts (s2-s1)+1
  end
end

# squares 3,9
# squares 4, 17 # 4, 9, 16
# squares 3, 100 # 4, 9, 16, 25, 36, 49, 64, 81, 100
# squares -10, 100
# squares -10, -8
# squares 0,1
# squares 0,0

# ===== Service Lane =====
# Given the entry and exit points in an array of widths, output max width one can travel through

def service_lane start, exit, lane
  puts lane[start..exit].min
end

lane = [2,3,1,2,3,2,3,3]

# service_lane 0,3,lane # 1
# service_lane 4,6,lane # 2
# service_lane 6,7,lane # 3
# service_lane 3,5,lane # 2
# service_lane 0,7,lane # 1

# === Cut the sticks =====
# Given an array of sticks, cut the sticks by the length of the smallest until none are left
# print number of sticks before each cut.

def cut_the_sticks arr
  sticks = []
  while arr.size != 0
    sticks << arr.size
    min_length = arr.min
    arr.map!{|x| x - min_length}
    arr.reject!{|x| x < 1}
  end
  p sticks
end

# cut_the_sticks [5,4,4,2,2,8] # 6,4,2,1
# cut_the_sticks [1,2,3,4,3,3,2,1] # 8,6,4,1

# ==== CHocolate Feast ====
# Given $n with choc cost = c, and wrapper trade-in value = m
# How many chocolate can be gotten?

def choc_store n,c,m
  total = wr = n/c
  while wr >= m
    bonus = wr/m
    wr -= bonus*m
    wr += bonus
    total += bonus
  end
  puts total
end

# choc_store 10, 2, 5 # 6
# choc_store 12, 4, 4 # 3
# choc_store 6, 2, 2 # 5

#===== Lisas WorkBook ====
# Given an array of problems in each chapter, and number of problems that can fit on each page
# Figure out when problem number and page number coincide, that is a special problem. Count how many.

def lisas_wbk prbs, prbs_per_chap
  pages,count = [], 0
  prbs_per_chap.each do |chap|
    num = chap/prbs
    rem = chap%prbs
    num.times{ pages<<prbs}
    pages << rem unless rem.zero?
  end
  prbs_per_chap.map!{|x| (1..x).to_a}.flatten!
  pages.map!{ |x| prbs_per_chap.shift(x) }
  pages.each_with_index{ |x,xi| count+=1 if x.include? (xi+1) }
  p count
end

# lisas_wbk 3, [4,2,6,1,10] # 4

require 'pp'
class PP
  class << self
    alias_method :old_pp, :pp
    def pp(obj, out = $>, width = 40)
      old_pp(obj, out, width)
    end
  end
end
# PP.pp(copy_g, $>, 40)

#===== Cavity Map =======
# Given a square map, find the cells where a cell is not on the border and each cell adjacent is smaller

def not_borders? xi,yi,size
  xi != 0 and yi != 0 and xi != size and yi != size
end

def adj_cells_smaller? grid,xi,yi,y
  grid[xi][yi+1] < y and grid[xi][yi-1] < y
end

def cavity_map grid
  copy_g = grid
  size = grid.size-1

  grid.each_with_index do |x,xi|
    x.each_with_index do |y,yi|
      copy_g[xi][yi] = 'X' if not_borders? xi,yi,size and adj_cells_smaller? grid,xi,yi,y
    end
  end
  pp copy_g
end

grid = [[1,1,1,2],
        [1,9,1,2],
        [1,8,9,2],
        [1,2,3,4]]

# cavity_map grid
