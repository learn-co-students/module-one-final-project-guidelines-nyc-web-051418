#this file holds the Word class and its class method to persist words in the database

class Word < ActiveRecord::Base
  has_many :games
  has_many :users, through: :games

  def self.create_word(new_random_string, max_score)
    Word.create(word: new_random_string, max_score: max_score)
  end
end
