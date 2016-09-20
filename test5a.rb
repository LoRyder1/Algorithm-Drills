# ========= Calculate Mean ==========

arr = [1,2,3,4,5,6,7]
arr2 = [1,2,3,4,5,6,7,8]
arr3 = [1,2,3,3,3,2,1,8]

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

# p median arr
# p median arr2

def mode arr
  freq, target = Hash.new(0), []
  arr.each do |num|
    freq.store(num, freq[num]+1)
  end
  freq.each do |k,v|
    if v == freq.values.max
      target << k
    end
  end
  target
end

p mode arr3
