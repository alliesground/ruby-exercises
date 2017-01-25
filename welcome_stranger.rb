ary = %w(Dan Miller Jones)
hsh = {title: 'Senior', occupation: 'Developer'}

def greetings(ary, hsh)
  "Hello, #{name(ary)}! Nice to have a #{hsh[:title]} #{hsh[:occupation]} around."
end

def name (ary)
  ary.join(' ')
end

puts greetings(ary, hsh)
