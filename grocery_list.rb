require 'pry'

grocery_list = [['grapes', 3], ['apple', 1], ['banana', 4], ['cherry', 10]] 

def convert(grocery_list)
  all_fruits = []

  grocery_list.each do |fruits|
    fruit = fruits.first
    quantity = fruits.last

    quantity.times do
      all_fruits << fruit
    end
  end
  all_fruits
end

puts convert(grocery_list)
