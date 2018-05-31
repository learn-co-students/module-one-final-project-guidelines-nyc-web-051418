def welcome
  puts "Welcome to iBartend"
end

def all_drink_names
  drinks = Drink.all.map { |drink| drink.name }
  puts drinks.sort
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
    # sql = <<-SQL
    # SELECT name FROM drinks WHERE (iba = ?)
    # SQL
    #
    # DB[:conn].execute(sql, "Unforgettables")
    unforgettables = Drink.all.where(iba: "Unforgettables")

    puts unforgettables.map { |unfo| unfo.name }


  elsif answer == "2"
    new_era_drinks = Drink.all.where(iba: "New Era Drinks")

    puts new_era_drinks.map { |new_era| new_era.name }
  elsif answer == "3"

    contemporary = Drink.all.where(iba: "Contemporary Classics")

    puts contemporary.map { |con| con.name }
  else
    puts "Unvalid Answer!"
  end


end
