require 'active_record'
require 'sqlite3'

class Drink < ActiveRecord::Base
  has_many :recipes
  has_many :ingredients, through: :recipes
end
