def check_number (arg)
  unless double_number? (arg)
    return 2 * arg 
  end
  arg
end

def double_number? (arg)
  if odd_number_of_digits? (arg)
    return false
  else
    arg = arg.to_s
    slice_point = arg.size / 2

    left_part(arg, slice_point) == right_part(arg, slice_point)
  end 
end

def left_part (arg, slice_point)
  arg.slice(0...slice_point)
end

def right_part (arg, slice_point)
  arg.slice(slice_point...(arg.size))
end

def odd_number_of_digits? (arg)
  if (arg.to_s.size % 2) == 0
    false
  else
    true
  end
end

puts <<OUTPUT
  #{check_number(1234)}

  #{check_number(123)}

  #{check_number(1212)}
OUTPUT


