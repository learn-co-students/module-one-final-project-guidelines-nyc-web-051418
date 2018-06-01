require 'active_record'
require 'sqlite3'

class Recipe < ActiveRecord::Base
  belongs_to :drink
  belongs_to :ingredient
end
