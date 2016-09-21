# The AND bitwise operation takes two sets of bits and for each pair of bits (the two bits at the same index in each set) returns 11 if both bits are 11. Otherwise, it returns 00.

1 & 1 # 1
1 & 0 # 0


5 & 6
# gives 4

# at the bit level:
#     0101  (5)
#   & 0110  (6)
#   = 0100  (4)

# ======================================================================

# The OR bitwise operation takes two sets of bits and for each pair of bits (the two bits at the same index in each set) returns 11 if either of the bits are 11. Otherwise, it returns 00.

1 | 1 # 1
1 | 0 # 1
0 | 1 # 1
0 | 0 # 0

5 | 6
# gives 7

# at the bit level:
#     0101  (5)
#   | 0110  (6)
#   = 0111  (7)

# ======================================================================

# The NOT bitwise operation takes one set of bits, and for each bit returns 00 if the bit is 11, and 11 if the bit is 00.

~ 1 # 0
~ 0 # 1

~ 5
# gives 10

# at the bit level:
#   ~ 0101  (5)
#   = 1010  (10)

# ======================================================================

# The XOR bitwise operation (or exclusive or) takes two sets of bits, and for each pair (the two bits at the same index in each bit set) returns 11 only if one but not both of the bits is 11. Otherwise, it returns 00.

1 ^ 1 # 0
1 ^ 0 # 1
0 ^ 1 # 1
0 ^ 0 # 0

5 ^ 6
# gives 3

# at the bit level:
#     0101  (5)
#   ^ 0110  (6)
#   = 0011  (3)

# ======================================================================

# A bit shift moves each digit in a set of bits left or right. The last bit in the direction of the shift is lost, and a 00 bit is inserted on the other end.

0010 << # 0100
1011 >> # 0101

# 0010 is 2
0010 << # 0100, which is 4

# Big O notation: How long an alogrithm takes to run 
  # - a way to express runtime in terms of 
      # - how quickly the runtime grows
      # - relative to the input
      # - as the input gets arbitrarily large

# = O(1) constant time
# = O(n) linear time
# = O(n^2) quadratic time