class User < ActiveRecord::Base
has_many :games
has_many :words, through: :games
@@current_user

def self.current_user
@@current_user
end

def self.find_or_create(playername)
  User.find_or_create_by(name: playername)
end
end
