require 'active_record'
require 'sqlite3'

class Ingredient < ActiveRecord::Base
  has_many :recipes
  has_many :drinks, through: :recipes

  def self.find_or_create(ingredient)
    # ing = Ingredient.find_by(name: ingredient)
    # binding.pry
    # if ing == nil
    #   new_ing = Ingredient.create(name: ingredient)
    # else
    #   new_ing = ing
    # end
    # new_ing
  end

end
