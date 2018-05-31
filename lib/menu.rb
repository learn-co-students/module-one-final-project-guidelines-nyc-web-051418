def menu_method
  prompt = TTY::Prompt.new
  pastel = Pastel.new
  font = TTY::Font.new(:starwars)
  # App Title
  puts pastel.white(font.write("Pub Trivia"))

  # The user is prompted to enter their username. The database is called to check if the name exists. If it doesn't then a new user is added to the database.
  name = prompt.ask('What is your username?')
  user = User.name_check(name)
  puts "Welcome, #{user.name}!"

  # Origin menu prompts
  initial_menu = prompt.select("What would you like to do?",["Play", "See High Scores", "Player Stats","Clear Player Statistics", "Exit"])
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
    elsif initial_menu == "Clear Player Statistics"
      Stats.clear_stats(user)
    else
      puts "Goodbye!"
    end
end
