require_relative '../app/models/user.rb'
require_relative 'game_method.rb'
require_relative '../app/models/highscores.rb'
require_relative '../app/models/questions.rb'
require_relative '../app/models/answers.rb'
require_relative '../app/models/stats.rb'
require_relative 'return_to_menu.rb'



def menu_method
  prompt = TTY::Prompt.new
  pastel = Pastel.new
  font = TTY::Font.new(:starwars)
  # App Title
  puts pastel.white(font.write("Pub Quiz"))

  # The user is prompted to enter their username. The database is called to check if the name exists. If it doesn't then a new user is added to the database.
  name = prompt.ask('What is your username?')
  user = User.name_check(name)
  puts "Welcome, #{user.name}!"

  initial_menu = prompt.select("What would you like to do?",["Play", "See High Scores", "Player Stats","Exit"])
    if initial_menu == "Play"
      game_method(user)
    elsif initial_menu == "See High Scores"
      Highscore.show_scores
      return_to_menu
    elsif initial_menu == "Player Stats"
      Stats.call_stats(user)
      play_a_game = prompt.select("Would you like to play?",["Yes", "No"])
      if play_a_game == "Yes"
        game_method(user)
      end
    else
      puts "Goodbye!"
    end
end
