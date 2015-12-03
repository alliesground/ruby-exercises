contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
            ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]

contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}

contact["Joe Smith"][:email] = contact_data[0][0]
contact["Joe Smith"][:address] = contact_data[0][1]
contact["Joe Smith"][:phone] = contact_data[0][2]
contact["Sally Johnson"][:email] = contact_data[1][0]
contact["Sally Johnson"][:address] = contact_data[1][1]
contact["Sally Johnson"][:phone] = contact_data[1][2]


