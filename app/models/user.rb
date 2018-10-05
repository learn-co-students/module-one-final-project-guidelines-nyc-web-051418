#this file holds the User class and its class methods related to CRUD players

class User < ActiveRecord::Base
  has_many :games
  has_many :words, through: :games

  @@current_user = ""
  @@login_temp_user = ""

  def self.save_login_user(player_name)
    @@login_temp_user = player_name
  end

  def self.login_user
    @@login_temp_user
  end

  def self.current_user
    @@current_user
  end

  def self.find_or_create_player(player_name = @@login_temp_user)
    user = User.find_or_create_by(name: player_name)
    @@current_user =  user
  end

  def self.last_player
    User.all.last
  end

  def self.update_user_name
    player = nil
    puts "Players: #{User.all.map.with_index {|user, i| "#{i}. #{user[:name].capitalize}"}.join(", ")}"
    while player.nil?
      player_name = PROMPT.ask('Enter user name:', default: " ").downcase
      player = User.find_by(name: player_name)
    end
    new_player_name = PROMPT.ask('User found. Enter new name for player:', default: "#{player[:name]}").downcase
    player.update(name: new_player_name)
    find_or_create_player(new_player_name)
    menu_option
  end
end
