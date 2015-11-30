puts "Please type your name"
name = gets.chomp

puts "Now enter your last name"
last_name = gets.chomp
puts "Hello #{name} #{last_name}"

10.times { puts "#{name} #{last_name}" }
