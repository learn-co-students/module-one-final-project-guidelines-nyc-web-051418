require_relative '../config/environment'
require 'colorized_string'

def intro
  puts "
  ██████╗██████╗  █████╗ ███████╗██╗   ██╗     █████╗ ███╗   ██╗ █████╗  ██████╗ ██████╗  █████╗ ███╗   ███╗███████╗
  ██╔════╝██╔══██╗██╔══██╗╚══███╔╝╚██╗ ██╔╝    ██╔══██╗████╗  ██║██╔══██╗██╔════╝ ██╔══██╗██╔══██╗████╗ ████║██╔════╝
  ██║     ██████╔╝███████║  ███╔╝  ╚████╔╝     ███████║██╔██╗ ██║███████║██║  ███╗██████╔╝███████║██╔████╔██║███████╗
  ██║     ██╔══██╗██╔══██║ ███╔╝    ╚██╔╝      ██╔══██║██║╚██╗██║██╔══██║██║   ██║██╔══██╗██╔══██║██║╚██╔╝██║╚════██║
  ╚██████╗██║  ██║██║  ██║███████╗   ██║       ██║  ██║██║ ╚████║██║  ██║╚██████╔╝██║  ██║██║  ██║██║ ╚═╝ ██║███████║
  ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝       ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝
  ".colorize(color: :yellow, mode: :blink) + " \nBy: Albert Carreras, Steven Chen, Ledio Bode".colorize(color: :magenta, mode: :bold)
  puts " \n"
  puts "\n                                    ## ".colorize(color: :magenta, mode: :blink) + "INSTRUCTIONS".colorize(color: :magenta, mode: :bold) + " ##".colorize(color: :magenta, mode: :blink)
  puts "=========================================================================================================".colorize(color: :magenta, mode: :bold)
  puts "##".colorize(color: :magenta, mode: :blink) + " The player is given a randomly generated 9-letter string.".colorize(color: :yellow, mode: :bold)
  puts "##".colorize(color: :magenta, mode: :blink) + " The player is given 25 seconds to find as many words (anagrams!) as they can within the string.".colorize(color: :yellow, mode: :bold)
  puts "##".colorize(color: :magenta, mode: :blink) + " The player is given 1 point for each letter in the word they found.".colorize(color: :yellow, mode: :bold)
  puts "##".colorize(color: :magenta, mode: :blink) + " Words have to be at least 2 letters.".colorize(color: :yellow, mode: :bold)
  puts "##".colorize(color: :magenta, mode: :blink) + " Make sure to check out the scoreboard for the top scores!  Have fun!!!".colorize(color: :yellow, mode: :bold)
  puts "=========================================================================================================\n".colorize(color: :magenta, mode: :bold)
end

def menu
  user_select = PROMPT.select("\nPlease select your choice?".colorize(mode: :bold), %w[Play Scoreboard Quit])
  
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
    puts "\nPlease enter your" + " First Name".colorize(color: :magenta, mode: :bold) + "....".colorize(color: :magenta, mode: :blink)
  first_name = gets.chomp

    puts "\nPlease enter your" + " Last Name".colorize(color: :magenta, mode: :bold) + "....".colorize(color: :magenta, mode: :blink)
  last_name = gets.chomp

  name = (first_name[0..9] + last_name[0..5]).downcase

  User.find_or_create(name)
end
