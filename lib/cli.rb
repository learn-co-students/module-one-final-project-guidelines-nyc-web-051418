def welcome
  puts "Welcome to iBartend"
end

def all_drink_names
  drinks = Drink.all.map { |drink| drink.name }
  puts drinks.sort
end

def get_recipe_by_drink_name(name)

  drink = Drink.all.where(name: name)[0]

  ingre = drink.ingredients.map { |ing| ing.name }.join(", ")
  measures = drink.ingredients.map { |ing| ing.measure + ing.name }.join(", ")
  puts "#{drink.name} is an #{drink.category} served in #{drink.glass} using #{ingre}"
  puts "\n"
  puts "Measures as follows: #{measures}"
  puts "\n"
  puts "Instructions for #{drink.name}:"
  puts "\n"
  puts "#{drink.instructions}"
  puts "\n"
  puts "1. Return to the drinks menu"
  puts "2. Input new drink name"
  answer = gets.chomp
  if answer == "1"
    all_drink_names
  elsif answer == "2"
    puts "Enter drink name:"
    drink_name = gets.chomp
    get_recipe_by_drink_name(drink_name)
  end

end

def list_of_ibas
  drinks = Drink.all.map { |drink| drink.iba }
  selected_drinks = drinks.select { |drink| drink != nil }
  puts selected_drinks.uniq
end

def list_of_all_drinks_by_iba
  puts "Choose an IBA:"
  puts "1. Unforgettables"
  puts "2. New Era Drinks"
  puts "3. Contemporary Classics"
  answer = gets.chomp
  if answer == "1"

    unforgettables = Drink.all.where(iba: "Unforgettables")

    puts unforgettables.map { |unfo| unfo.name }


  elsif answer == "2"
    new_era_drinks = Drink.all.where(iba: "New Era Drinks")

    puts new_era_drinks.map { |new_era| new_era.name }
  elsif answer == "3"

    contemporary = Drink.all.where(iba: "Contemporary Classics")

    puts contemporary.map { |con| con.name }
  else
    puts "Invalid Answer!"
    list_of_all_drinks_by_iba
  end

end

def get_drink_name_by_ingredient
  puts "Input ingredient name"
  input_ingredient = gets.chomp
  ingredient = Ingredient.where(name: input_ingredient)

  drinks_of_ingredient = ingredient.map { |x| x.drinks }.flatten
  puts "Drinks with #{ingredient[0].name}:"
  puts "\n"
  puts drinks_of_ingredient.map { |drink| drink.name }

end
