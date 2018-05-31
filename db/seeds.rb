require 'rest-client'
require 'json'
require 'pry'

require_relative '../app/models/drink.rb'
require_relative '../app/models/ingredient.rb'
require_relative '../app/models/recipe.rb'


def get_ordinary_drinks_id
 ordinary_drink = RestClient.get("https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Ordinary_Drink")
 ordinary_drink_hash = JSON.parse(ordinary_drink)
 drink_names = ordinary_drink_hash["drinks"]
 drink_ids = drink_names.map { |x| x["idDrink"] }
end

def get_drinks_hash_from_id
 get_ordinary_drinks_id.each do |drinkvar|
   drink = RestClient.get("https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{drinkvar}")
   drink_hash = JSON.parse(drink)

   new_drink = Drink.new(api_id: drink_hash["drinks"][0]["idDrink"],
     name: drink_hash["drinks"][0]["strDrink"],
     category: drink_hash["drinks"][0]["strCategory"],
     iba: drink_hash["drinks"][0]["strIBA"],
     glass: drink_hash["drinks"][0]["strGlass"],
     instructions: drink_hash["drinks"][0]["strInstructions"]
   )

   new_drink.save

    idx = 1
    while idx < 16
      ingredient = drink_hash["drinks"][0]["strIngredient#{idx}"]
      if ingredient != ""
        new_ingredient = Ingredient.find_or_create_by(name: ingredient)
        Recipe.create(drink_id: new_drink.id, ingredient_id: new_ingredient.id)
      end
      # if drink_hash["drinks"][0]["strIngredient#{idx}"] != ""
      # if Ingredient.find_by(name: ingredient) == nil
        # new_ingredient = Ingredient.new(name: ingredient)
      #   new_ingredient.save
      #   new_recipe = Recipe.new(drink_id: new_drink.id, ingredient_id: new_ingredient.id)
      #   new_recipe.save
      # else
      #   recurring = Ingredient.find_by(name: ingredient)
      #   new_recipe = Recipe.new(drink_id: new_drink.id, ingredient_id: recurring.id)
      # end
      # new_ingredient = Ingredient.find_or_create_by(name: ingredient)
      # Recipe.create(drink_id: new_drink.id, ingredient_id: new_ingredient.id)
      idx += 1
    end
 end

end

get_drinks_hash_from_id


     # ingredient = drink_hash["drinks"][0]["strIngredient#{idx}"] if drink_hash["drinks"][0]["strIngredient#{idx}"] != ""




    #  if Ingredient.find_by(name: ingredient) == nil
    #    new_ingredient = Ingredient.new(name: ingredient)
    #    new_ingredient.save
    #    new_recipe = Recipe.new(drink_id: new_drink.id, ingredient_id: new_ingredient.id)
    #    new_recipe.save
    #
    # elsif Ingredient.find_by(name: ingredient) != nil
     #   recurring_ingredient = Ingredient.find_by(name: ingredient)
     #   new_recipe = Recipe.new(drink_id: new_drink.id, ingredient_id: recurring_ingredient.id)
     #   new_recipe.save
     # end

     # Ingredient.new(name: ingredient)
