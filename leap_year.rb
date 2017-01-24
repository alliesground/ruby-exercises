require 'pry'

class Year
  def self.leap?(num)
    divisible_by_4 = num % 4 == 0
    divisible_by_100 = num % 100 == 0
    divisible_by_400 =  num % 400 == 0

    divisible_by_4 && (!divisible_by_100 || divisible_by_400)
  end
end

#puts Year.leap? 1984


#--------------------------


# loop (0..length)
#   -start with the first char
#     - if length of substring is less than the given length of n
#         - break out of loop
#     - grab the substring starting from the first char to n
#     - display the substring
# do same with the next char in the loop

module Series
  private

  def out_of_range(idx, n)
    self[idx, n].length < n
  end

  def display_series(idx, n)
    puts self[idx, n]
  end
end

class String
  include Series

  def get_series_of(n)
    #binding.pry
    (0...(self.length)).each do |idx|
      break if out_of_range idx, n
      display_series idx, n
    end
  end
end


"01234".get_series_of(3)
