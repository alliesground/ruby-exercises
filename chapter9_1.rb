words = ["laboratory", 
         "experiment", 
         "Pans Labyrinth", 
         "elaborate", 
         "polar bear"
        ]

words.each do |word|
  if word =~ /lab/
    puts word
  else
    puts "no match"
  end
end
