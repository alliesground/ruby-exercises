number = 5

def count_down(num)
  puts num
  num -= 1
  return if num < 0
  sleep 0.5
  count_down(num)
end

count_down(5)
