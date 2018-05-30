class User < ActiveRecord::Base
  has_many :games
  has_many :words, through: :games

  # def self.find_or_create(player_name)
  #   existing_player = User.all.find do |instance|
  #     instance[name:] == player_name
  #
  #
  #
  # end
end
