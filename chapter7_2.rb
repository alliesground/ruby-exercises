hash1 = {name: "sam", age: 31}
hash2 = {occupation: "programmer", location: "sydney"}

p hash1.merge(hash2)

# with merge original hash does not change
p hash1

hash3 = { title: "indie game" }
hash4 = { release_date: 2012 }

hash3.merge!(hash4)

# with merge! the original hash3 changes
p hash3
