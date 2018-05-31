require_relative '../config/environment'

def menu
  prompt = TTY::Prompt.new
  user_select = prompt.select("Please select your choice?", %w(Play Scoreboard Quit))
  if user_select == "Play"
    user=get_name
    play_game(user)
  elsif user_select == "Scoreboard"
    scorecard
  elsif user_select == "Quit"
    puts "Bye!"
  end
end

def get_name
  puts "Please enter your first name"
  first_name = gets.chomp
  puts "Please enter your last name"
  last_name = gets.chomp
  name = (first_name[0..9] + last_name[0..5]).downcase
  User.find_or_create(name)
end
