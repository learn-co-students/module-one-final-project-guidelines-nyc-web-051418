require_relative '../app/models/user.rb'
require_relative 'game_method.rb'
require_relative '../app/models/highscores.rb'
require_relative '../app/models/questions.rb'
require_relative '../app/models/answers.rb'
require_relative '../app/models/stats.rb'

prompt = TTY::Prompt.new
pastel = Pastel.new
font = TTY::Font.new(:starwars)


# App Title
puts pastel.white(font.write("Pub Quiz"))

# The user is prompted to enter their username. The database is called to check if the name exists. If it doesn't then a new user is added to the database.
name = prompt.ask('What is your username?')
user = User.name_check(name)
puts "Welcome, #{user.name}!"

initial_menu = prompt.select("What would you like to do?",["Play", "See High Scores", "Player Stats"])
  if initial_menu == "Play"
    game_method(user)
  elsif initial_menu == "See High Scores"
    Highscore.show_scores
  elsif initial_menu == "Player Stats"
    Stats.call_stats(user)
  else
    Stats.reset(user)
  end
