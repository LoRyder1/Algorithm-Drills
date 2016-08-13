# ====Cancel class if fewer than x students show up ====



# angry_prof 3, [-1, -3, 4, 2] # Yes cancel class
# angry_prof 2, [0, -1, 2, 1] # No don't cancel class

# ==== Find the Decent Num =====
# Its digits can only be 3's and/or 5's.
# The number of 3's it contains is divisible by 5.
# The number of 5's it contains is divisible by 3.
# If there are more than one such number, we pick the largest one.



# decent_num 1   #   -1
# decent_num 3   #  555
# decent_num 5   #  33333
# decent_num 11   #  55555533333

# ======== Utopian Tree =========
# two cycles of growth in year = spring doubles in height, summer increase = +1, starting height = 1



# utopian_tree 0 # 1
# utopian_tree 1 # 2
# utopian_tree 4 # 7

# === Find Digits ===
# Given an integer, how many digits of integer can evenly divide integer



# find_digits 12
# find_digits 1012
# find_digits 1041

# ===Count all the squares in a given range ===



# squares 3,9
# squares 4, 17 # 4, 9, 16
# squares 3, 100 # 4, 9, 16, 25, 36, 49, 64, 81, 100
# squares -10, 100
# squares -10, -8
# squares 0,1
# squares 0,0

# ===== Service Lane =====
# Given the entry and exit points in an array of widths, output max width one can travel through



lane = [2,3,1,2,3,2,3,3]

# service_lane 0,3,lane # 1
# service_lane 4,6,lane # 2
# service_lane 6,7,lane # 3
# service_lane 3,5,lane # 2
# service_lane 0,7,lane # 1

# === Cut the sticks =====
# Given an array of sticks, cut the sticks by the length of the smallest until none are left
# print number of sticks before each cut.



# cut_the_sticks [5,4,4,2,2,8] # 6,4,2,1
# cut_the_sticks [1,2,3,4,3,3,2,1] # 8,6,4,1

# ==== CHocolate Feast ====
# Given $n with choc cost = c, and wrapper trade-in value = m
# How many chocolate can be gotten?



# choc_store 10, 2, 5 # 6
# choc_store 12, 4, 4 # 3
# choc_store 6, 2, 2 # 5

#===== Lisas WorkBook ====
# Given an array of problems in each chapter, and number of problems that can fit on each page
# Figure out when problem number and page number coincide, that is a special problem. Count how many.


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



grid = [[1,1,1,2],
        [1,9,1,2],
        [1,8,9,2],
        [1,2,3,4]]

# cavity_map grid
