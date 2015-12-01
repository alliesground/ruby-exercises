movies = { jaws: 1984,
           rocky: 1990,
           commando: 1998
         }

movies.each_key {|title| puts title}
movies.each_value {|year| puts year}
movies.each {|title, year| puts "#{title} => #{year}"}
