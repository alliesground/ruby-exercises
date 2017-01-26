ary = [1,2,3,4]

# my solution
#def rotate_array (ary)
#  new_ary = ary.map {|val| val}
#  first_ele = new_ary.shift
#  new_ary.push(first_ele)
#end

# best solution
def rotate_array(ary)
  ary[1..-1] + [ary[0]]
end

puts rotate_array (ary)
puts ary

