require_relative '../config/environment'
require 'colorized_string'

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

sleep(2)
#game start
menu
