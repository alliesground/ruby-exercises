require 'pry'

grocery_list = [['grapes', 3], ['apple', 1], ['banana', 4], ['cherry', 10]] 

def convert(grocery_list)
  grocery_list.map {|fruit, qty| [fruit] * qty}.flatten
end

puts convert(grocery_list)
