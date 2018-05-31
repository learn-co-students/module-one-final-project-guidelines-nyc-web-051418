require_relative '../config/environment'

def menu
  user_select = PROMPT.select("\nPlease select your choice?", %w[Play Scoreboard Quit])
  if user_select == 'Play'
    user = get_name
    play_game(user)
  elsif user_select == 'Scoreboard'
    scorecard
  elsif user_select == 'Quit'
    puts 'Bye!'
  end
end

def get_name
    puts "\nPlease enter your first name".colorize(color: :magenta)
  first_name = gets.chomp
    puts "\nPlease enter your last name".colorize(color: :magenta)
  last_name = gets.chomp
  name = (first_name[0..9] + last_name[0..5]).downcase
  User.find_or_create(name)
end
