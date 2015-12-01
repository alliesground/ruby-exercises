puts "Enter a number between 0 and 100"
number = gets.chomp.to_i

def evaluate_num(number)
 if number < 0
   puts "you cannot enter negative number"
 elsif number <= 50
   puts "#{number} is between 0 and 50"
 elsif number <= 100
   puts "#{number} is between 51 and 100"
 else
   puts "#{number} is above 100"
 end
end

def evaluate_num_with_case(number)
  case
  when number < 0
    puts "you cannot enter negative number"
  when number <= 50
    puts "#{number} is between 0 and 50"
  when number <= 100
    puts "#{number} is between 51 and 100"
  else
    puts "#{number} is above 100"
  end
end

evaluate_num(number)
evaluate_num_with_case(number)
