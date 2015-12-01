arr = [1,2,3,4]
new_arr = []

arr.each do |val|
  new_arr << val + 2
end

p arr
p new_arr
