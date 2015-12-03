arr = [1,2,3,4,5,6,7,8,9,10] 

new_arr = arr.select {|value| value % 2 != 0}
p new_arr
