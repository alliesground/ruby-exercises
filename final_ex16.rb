a = ['white snow', 'winter wonderland', 'melting ice',
     'slippery sidewalk', 'salted roads', 'white trees']

new_arr = []

new_arr = a.map {|val| val.split}

p new_arr.flatten


