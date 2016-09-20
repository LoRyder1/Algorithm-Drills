# ========= Calculate Mean ==========

arr = [1,2,3,4,5,6,7]
arr2 = [1,2,3,4,5,6,7,8]

def mean arr
  arr.reduce(:+)/arr.length
end

# p mean arr

def median arr
  mid = arr.size/2
  even_sum = arr[mid] + arr[mid-1]
  even_mid = even_sum.to_f/2 

  arr.size.odd? ? arr[mid] : even_mid
end

p median arr
p median arr2

def

