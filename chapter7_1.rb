family = {  uncles: ["bob", "joe", "steve"],
            sisters: ["jane", "jill", "beth"],
            brothers: ["frank","rob","david"],
            aunts: ["mary","sally","susan"]
          }


immediate_member = family.select {|k,v| k == :sisters || k == :brothers}

new_arr = immediate_member.values.flatten

p new_arr
