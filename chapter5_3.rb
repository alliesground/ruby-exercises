arr = ["name", "age", "dob"]

arr.each_with_index do |val, index|
  puts "#{index} => #{val}"
end
