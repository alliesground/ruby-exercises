ary = %w(Dan Miller Jones)
hsh = {title: 'Senior', occupation: 'Developer'}

def greetings(ary, hsh)
  "Hello, #{name(ary)}! Nice to have a #{title(hsh)} around."
end

def name (ary)
  ary.join(' ')
end

def title (hsh)
  hsh.values.join(' ')
end

puts greetings(ary, hsh)
