require 'pp'
# Calculate mean of [1,2,3,4,5]

def mean array
  length = array.length
  sum = 0 
  array.each do |x|
    sum += x
  end
  sum / length
end

arr = [1,2,3,4,5,6,7]
arr1 = [1,2,3,4,5,6]

# p mean(arr)

def median array
  length = array.length
  mid = length/2
  even_mid = array[mid] + array[mid-1]
  if (length.odd?)
    array[mid]
  else 
    even_mid.to_f / 2
  end
end

# p median(arr)
# p median(arr1)

def mode array
  freq = Hash.new(0)
  array.each do |num|
    freq.store(num, freq[num]+1)
  end
  target = []
  freq.each do |k,v|
    if v == freq.values.max
      target << k
    end
  end
  target
  
end
# p mode([1,1,1,3,3,4,5,6,6,6,5,5])



# ============== ARRAY AND HASH MOD =====================


def my_array_finding_method array, letter
  wooho = []
  array.each do |x|
    if x.class != Fixnum
      wooho << x if x.include? letter
    end
  end
  wooho
end

def my_hash_finding_method hash, num
  my_array = []
  hash.each do |k,v|
    if v == num
      my_array << k
    end
  end
  my_array
end

def my_array_modification_method array, num
  mod_arr = []
  array.each do |x|
    if x.class == Fixnum
      mod_arr << x += num
    else
      mod_arr << x
    end
  end
  mod_arr
end

def my_hash_modification_method hash, num
  mod_hash = {}
  hash.each do |k,v|
    mod_hash.store(k, v+2)
  end
  mod_hash
end

def my_array_sorting_method array
  sorted = []
  nums = [] 
  words = []
  array.each do |x|
    if x.class == Fixnum
      nums << x
    else
      words << x
    end
  end
  nums.sort.concat(words.sort)
end

def my_hash_sorting_method hash, kind
  # sorted = []
  if kind == 'age'
    hash.sort_by{|k,v| v }
  end
end

def my_deletion_method array, letter
  array.each do |x|
    if x.class != Fixnum
      if x.include? letter
        array.delete(x)
      end
    end
  end
  array
end

def my_deletion_method hash, word
  hash.each do |k,v|
    if k == word
      hash.delete(k)
    end
  end
  hash
end



i_want_pets = ["I", "want", 3, "pets", "but", "only", "have", 2, ":(." ]
my_family_pets_ages = {"Evi" => 6, "Hoobie" => 3, "George" => 12, "Bogart" => 4, "Poly" => 4, 
  "Annabelle" => 0, "Ditto" => 3}

# p my_array_finding_method(i_want_pets, "t") #=> should return ["want","pets","but"]
# p my_hash_finding_method(my_family_pets_ages, 3) #=> should return ["Hoobie", "Ditto"]
# p my_array_modification_method(i_want_pets, 1) 
#=> ["I", "want", 4, "pets", "but", "only", "have", 3, ":(." ] 
# p my_hash_modification_method(my_family_pets_ages, 2) 
#=> {"Evi" => 8, "Hoobie" => 5, "George" => 14, "Bogart" => 6, "Poly" => 6, "Annabelle" => 2, "Ditto" => 5}
# p my_array_sorting_method(i_want_pets) #=>
# ["3", "4", "I", "but", "have", "only", "pets", "want"]
# p my_hash_sorting_method(my_family_pets_ages, 'age') #=>
# [["Annabelle", 2], ["Ditto", 5], ["Hoobie", 5], ["Bogart", 6], ["Poly", 6], ["Evi", 8], ["George", 14]] 
# p my_deletion_method(i_want_pets, "a")
# #=> ["I", 4, "pets", "but", "only", 3, ":(." ]
# p my_deletion_method(my_family_pets_ages, "George") 
# #=> {"Evi" => 8, "Hoobie" => 5, "Bogart" => 6, "Poly" => 6, "Annabelle" => 2, "Ditto" => 5}



def superfizzbuzz array
  array.map do |x|
    if x % 3 == 0 && x % 5 == 0
      "fizzbuzz"
    elsif x % 3 == 0
      "fizz"
    elsif x % 5 == 0
      "buzz"
    else
      x
    end
  end
end

# p superfizzbuzz([1,3,5,9,15,16])
# p superfizzbuzz([1,3,9,15,5, 30,23849])


## Release 0: Create an Array of Students

# Create an array `students` with 5 Students.** Each student should be assigned a `first_name`, and 5 test scores (scores are between 0 and 100) when it is created. The first Student should be named `"Alex"` with scores `[100,100,100,0,100]`. Once you've done this properly, release 0 tests should pass.

# ## Release 1: Average Scores
# Compute and assign a score average and a letter grade to each student.Letter grades are based on the average (A for >=90%, B for >=80%, C for >= 70%, D for >= 60% and F for < 60%). 

# ## Release 2: Linear Search

# Write a [linear_search](http://en.wikipedia.org/wiki/Linear_search) method that searches the student array for a student's `first_name` and returns the position of that student if they are in the array. If the student is not in the array then the method should return -1.

class Student
  attr_reader :first_name, :scores, :linear_search
  def initialize first_name, scores
    @first_name, @scores = first_name, scores
  end

  def average
    sum = 0
    scores.each do |x|
      sum += x
    end
    sum.to_f/scores.length
  end

  def letter_grade
    if average >= 90 
      "A"
    elsif average >= 80
      "B"
    elsif average >= 70
      "C"
    else
      "F"
    end
  end
end

def linear_search students, name
  students.each_with_index do |x, index|
    if x.first_name == name
      return index
    else
      return -1
    end
  end
end


alex = Student.new('Alex',[100,100,100,0,100])
bob = Student.new('bob',[100,100,100,0,100])
steve = Student.new('steve',[100,100,100,0,100])
mike = Student.new('mike',[100,100,100,0,100])
nick = Student.new('nick',[100,100,100,0,100])

students = [alex,bob,steve,mike,nick]


# p students[0].first_name == "Alex"
# p students[0].scores.length == 5
# p students[0].scores[0] == students[0].scores[4]
# p students[0].scores[3] == 0


# # # Tests for release 1:

# p students[0].average == 80
# p students[0].letter_grade == 'B'

# # Tests for release 2:

# p linear_search(students, "Alex") == 0
# p linear_search(students, "NOT A STUDENT") == -1

# - `Rectangle#area`, which returns the area of the rectangle
# - `Rectangle#perimeter`, which returns the perimeter of the rectangle
# - `Rectangle#diagonal`, which returns the length of the rectangle's diagonal as a `Float`
# - `Rectangle#square?`, which returns a boolean

class Rectangle
  attr_reader :width, :height
  def initialize width, height
    @width, @height = width, height
  end

  def area
    width * height
  end

  def perimeter
    2*(width) + 2*(height)
  end

  def diagonal
    c_squared = width ** 2 + height ** 2
    Math.sqrt(c_squared)
  end

  def square?
    width == height
  end
end

# p Rectangle.new(10,20).area == 200
# p Rectangle.new(10,20).perimeter == 60
# p Rectangle.new(10,20).diagonal
# p Rectangle.new(3,4).diagonal # 9 + 16 = 25 diagonal = 5
# p Rectangle.new(3,4).square
# p Rectangle.new(4,4).square

def reverse_words sentence
  sentence.split(" ").map{ |x| x.reverse }.join(" ")
end

# p reverse_words("Ich bin ein Berliner") # "hcI nib nie renilreB"


# Traversing a 2D Array

# return middle coordinate and element


class BoggleBoard
  attr_reader :board
  def initialize board
    @board = board
  end

  def get_row row
    board[row]
  end

  def get_col col
    board.map{|row| row[col]}
  end

  def create_word *arguments
    word = []
    arguments.map{|row, col| word << board[row][col]}
    word.join
  end

  def middle_of_array
    mid_col = board[0].length/2
    mid_row = board.length/2
    board[mid_row][mid_col]
  end

end

dice_grid = [["b", "r", "a", "e", "x"],
             ["i", "o", "d", "t", "x"],
             ["e", "c", "l", "r", "x"],
             ["t", "a", "k", "e", "x"],
             ["t", "a", "k", "e", "x"]]
 
dice_grid2 = [["a", "b", "c"], 
              ["d", "e", "f"],
              ["g", "h", "i"]]

boggle_board = BoggleBoard.new(dice_grid)
boggle_board2 = BoggleBoard.new(dice_grid2)