def capify(str)
  if str.length > 10
    str.upcase
  else
    str
  end
end

puts capify("hello world")
