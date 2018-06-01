FONT = TTY::Font.new(:standard)
PASTEL = Pastel.new
PROMPT = TTY::Prompt.new

def welcome
  puts "\n"
  puts PASTEL.red(FONT.write("Welcome   to   iBartend"))
  # puts "Welcome to iBartend"
  puts "\n"
  menu
end

def menu
  # puts "\n"
  # puts PASTEL.cyan.bold("Menu")
  # puts "\n"
  # puts "\n"
  # puts PASTEL.magenta("Please select from the following options:")
  # puts "\n"
  # puts "Press 1 for Drink Menu"
  # puts "Press 2 for Ingredient List"
  # puts "Press 3 for IBA Categories"
  # puts "Press 4 for Glass Type"
  # puts "Press 0 if you've had enough"
  # puts "\n"
  # answer = gets.chomp
  # if answer == "1"
  #   all_drink_names
  # elsif answer == "2"
  #   all_ingredient_names
  # elsif answer == "3"
  #   list_of_ibas
  # elsif answer == "4"
  #   get_glass_types
  answer = PROMPT.select(PASTEL.magenta("Menu \n \n Please select from the following options: \n \n")) do |menu|
    menu.choice 'Drink Menu'
    menu.choice 'Ingredient List'
    menu.choice 'IBA Categories'
    menu.choice 'Glass Types'
    menu.choice 'Exit bar'
  end
  puts "\n"
  if answer == 'Drink Menu'
    all_drink_names
  elsif answer == "Ingredient List"
    all_ingredient_names
  elsif answer == "IBA Categories"
    list_of_ibas
  elsif answer == "Glass Types"
    get_glass_types
  elsif answer == 'Exit bar'
    puts "\n"
    puts "\n"
    puts "\n"
    puts "\n"
    puts "\n"
    puts "\n"
    puts "\n"
    puts PASTEL.red("Hope you've enjoyed our bar! don't forget to tip your programmers!")
    puts "\n"
    puts "\n"
    puts "\n"
    puts "\n"
    puts "\n"
    puts "\n"
    puts "\n"
  end
end

def all_drink_names
  drinks = Drink.all.map { |drink| drink.name }
  puts drinks.sort
  puts "\n"
  puts PASTEL.magenta("Press 1 to input a drink name")
  puts PASTEL.red("Press 0 to go back to the menu")
  answer = gets.chomp
  if answer == "1"
    puts "\n"
    puts PASTEL.magenta("Type your drink name:")
    puts "\n"
    drink = gets.chomp
    get_recipe_by_drink_name(drink)
  elsif answer == "0"
    menu
  else
    puts "\n"
    puts PASTEL.magenta("Invalid input. Try again.")
    all_drink_names
  end
end

def all_ingredient_names
  ingredients = Ingredient.all.map { |ing| ing.name }
  ings = ingredients.select { |i| i if i != nil}
  puts "\n"
  puts ings.uniq!.sort!
  puts "\n"
  puts PASTEL.magenta("Press 1 to filter drinks by ingredient name")
  puts PASTEL.red("Press 0 to go back to menu")
  puts "\n"
  answer = gets.chomp
  if answer == "1"
    get_drink_name_by_ingredient
    puts "\n"
  elsif answer == "0"
    menu
  else
    puts PASTEL.magenta("Invalid input. Try again.")
    all_ingredient_names
  end
end



def get_recipe_by_drink_name(name)

  drink = Drink.all.where(name: name)[0]

  ingre = drink.ingredients.map { |ing| ing.name }.join(", ")
  measures = drink.ingredients.map { |ing| ing.measure + " " + ing.name }.join(", ")
  puts "\n"
  puts "#{drink.name} is an #{drink.category} served in a #{drink.glass} using #{ingre}"
  puts "\n"
  puts PASTEL.magenta("Measures as follows:")
  puts "\n"
  puts "#{measures}"
  puts "\n"
  puts PASTEL.magenta("Instructions for #{drink.name}:")
  puts "\n"
  puts "#{drink.instructions}"
  puts "\n"
  puts PASTEL.magenta("Press 1 to return to the drinks menu")
  puts PASTEL.cyan("Press 2 to input new drink name")
  puts PASTEL.red("Press 0 to go back to menu")
  answer = gets.chomp
  if answer == "1"
    puts "\n"
    all_drink_names
  elsif answer == "2"
    puts "\n"
    puts PASTEL.magenta("Enter drink name:")
    drink_name = gets.chomp
    get_recipe_by_drink_name(drink_name)
  elsif answer == "0"
    puts "\n"
    menu
  else
    puts "\n"
    puts PASTEL.magenta("Invalid input. Try again.")
    get_recipe_by_drink_name(name)
  end

end

def list_of_ibas
  # drinks = Drink.all.map { |drink| drink.iba }
  # selected_drinks = drinks.select { |drink| drink != nil }
  puts "\n"
  # puts selected_drinks.uniq
  puts PASTEL.magenta("An IBA official cocktail is one of many cocktails selected by the International Bartenders Association (IBA) for use in the annual World Cocktail Competition (WCC) in bartending. IBA cocktails are specified in centilitres (cl) rather than the more commonly used millilitres (ml).")
  list_of_all_drinks_by_iba

end

def list_of_all_drinks_by_iba
  puts "\n"
  puts PASTEL.magenta("Choose an IBA:")
  puts "\n"
  puts PASTEL.magenta("Press 1 for Unforgettables")
  puts PASTEL.red("Press 2 for New Era Drinks")
  puts PASTEL.cyan("Press 3 for Contemporary Classics")
  puts "\n"
  answer = gets.chomp
  if answer == "1"
    puts "\n"
    unforgettables = Drink.all.where(iba: "Unforgettables")
    puts PASTEL.magenta("unforgettables drinks:")
    puts "\n"
    puts unforgettables.map { |unfo| unfo.name }.sort
    puts "\n"
    puts PASTEL.magenta("Press 1 to select drink by name")
    puts PASTEL.cyan("Press 2 to return to the IBA list")
    puts PASTEL.red("Press 0 to go back to menu")
    puts "\n"
    input = gets.chomp
    if input == "1"
      puts "\n"
      puts PASTEL.magenta("Type the name of your drink:")
      input_drink = gets.chomp
      get_recipe_by_drink_name(input_drink)
    elsif input == "2"
      puts "\n"
      list_of_all_drinks_by_iba
    elsif input == "0"
      menu
    else
      puts PASTEL.magenta("Invalid input. Try again.")
    end

  elsif answer == "2"
    puts "\n"
    new_era_drinks = Drink.all.where(iba: "New Era Drinks")
    puts PASTEL.magenta("New era drinks:")
    puts "\n"
    puts new_era_drinks.map { |new_era| new_era.name }.sort

    puts "\n"
    puts PASTEL.magenta("Press 1 to select drink by name")
    puts PASTEL.cyan("Press 2 to return to the IBA list")
    puts PASTEL.red("Press 0 to go back to menu")
    puts "\n"
    input = gets.chomp
    if input == "1"
      puts "\n"
      puts PASTEL.magenta("Type the name of your drink:")
      input_drink = gets.chomp
      get_recipe_by_drink_name(input_drink)
    elsif input == "2"
      puts "\n"
      list_of_all_drinks_by_iba
    elsif input == "0"
      menu
    else
      puts PASTEL.magenta("Invalid input. Try again.")
    end
  elsif answer == "3"
    puts "\n"

    contemporary = Drink.all.where(iba: "Contemporary Classics")
    puts PASTEL.magenta("Contemporary drinks:")
    puts "\n"
    puts contemporary.map { |con| con.name }.sort

    puts "\n"
    puts PASTEL.magenta("Press 1 to select drink by name")
    puts PASTEL.cyan("Press 2 to return to the IBA list")
    puts PASTEL.red("Press 0 to go back to menu")
    puts "\n"
    input = gets.chomp
    if input == "1"
      puts "\n"
      puts PASTEL.magenta("Type the name of your drink:")
      input_drink = gets.chomp
      get_recipe_by_drink_name(input_drink)
    elsif input == "2"
      puts "\n"
      list_of_all_drinks_by_iba
    elsif input == "0"
      menu
    else
      puts PASTEL.magenta("Invalid input. Try again.")
    end
  else
    puts "\n"
    puts PASTEL.magenta("Invalid Answer. Try again.")
    puts "\n"
    list_of_all_drinks_by_iba
  end

end

def get_drink_name_by_ingredient
  puts "\n"
  puts PASTEL.magenta("Input ingredient name:")
  puts "\n"
  input_ingredient = gets.chomp
  ingredient = Ingredient.where(name: input_ingredient)

  drinks_of_ingredient = ingredient.map { |x| x.drinks }.flatten.sort
  puts "\n"
  puts PASTEL.magenta("Drinks with #{ingredient[0].name}:")
  puts "\n"
  puts drinks_of_ingredient.map { |drink| drink.name }.sort
  puts "\n"
  puts PASTEL.magenta("Press 1 to view a drink")
  puts PASTEL.cyan("Press 2 to input a differnet ingredient")
  puts PASTEL.red("Press 0 to go back to menu")
  answer = gets.chomp
  if answer == "1"
    puts "\n"
    puts PASTEL.magenta("Type the drink's name:")
    drink = gets.chomp
    get_recipe_by_drink_name(drink)
  elsif answer == "2"
    puts "\n"
    get_drink_name_by_ingredient
  elsif answer == "0"
    puts "\n"
    menu
  else
    puts "\n"
    puts PASTEL.magenta("Invalid input. Try again.")
    get_drink_name_by_ingredient
  end
end

def get_glass_types
  # x = Drink.all.map { |drink| drink.glass }
  # y = x.uniq.sort
  # c = y.map {|x| x.split}
  # v = c.map{|c| c.map{|x| x.capitalize}.join(" ")}
  # puts "\n"
  # puts v.uniq
  # puts "\n"
  # find_drink_by_glass
  puts "\n"
  puts Drink.all.map { |x| x.glass }.uniq.sort
  # puts drinks.map { |drink| drink.split(" ").map { |word| word.capitalize }.join(" ") }.uniq.sort
  puts "\n"
  find_drink_by_glass
end

def find_drink_by_glass
  puts PASTEL.magenta("Input your glass type:")
  puts "\n"
  answer = gets.chomp
  # lower_case_answer = answer.split
  # lower = lower_case_answer[0] + " " + lower_case_answer[1].downcase

  drinks = Drink.all.where(glass: answer)
  # binding.pry
  puts "\n"
  puts PASTEL.magenta("These drinks contain #{answer}:")
  puts drinks.map { |drink| drink.name }.sort
  puts "\n"
  puts PASTEL.magenta("Press 1 to input a drink name")
  puts PASTEL.cyan("Press 2 to select a different glass")
  puts PASTEL.red("Press 0 to go back to menu")
  puts "\n"
  input = gets.chomp

  if input == "1"
    puts PASTEL.magenta("Type in the drink name:")
    drink_input = gets.chomp
    get_recipe_by_drink_name(drink_input)
    # drinks = Drink.all.where(glass: answer && lower_case_answer)
    #
    # puts drinks.map { |drink| drink.name }.sort
  elsif input == "2"
    get_glass_types
    # find_drink_by_glass
  elsif input == "0"
    puts "\n"
    menu
  else
    puts PASTEL.magenta("Invalid input. Try again.")
    puts "\n"
    find_drink_by_glass
  end
end
