require_relative '../config/environment'
require 'colorized_string'

puts "
██████╗██████╗  █████╗ ███████╗██╗   ██╗     █████╗ ███╗   ██╗ █████╗  ██████╗ ██████╗  █████╗ ███╗   ███╗███████╗
██╔════╝██╔══██╗██╔══██╗╚══███╔╝╚██╗ ██╔╝    ██╔══██╗████╗  ██║██╔══██╗██╔════╝ ██╔══██╗██╔══██╗████╗ ████║██╔════╝
██║     ██████╔╝███████║  ███╔╝  ╚████╔╝     ███████║██╔██╗ ██║███████║██║  ███╗██████╔╝███████║██╔████╔██║███████╗
██║     ██╔══██╗██╔══██║ ███╔╝    ╚██╔╝      ██╔══██║██║╚██╗██║██╔══██║██║   ██║██╔══██╗██╔══██║██║╚██╔╝██║╚════██║
╚██████╗██║  ██║██║  ██║███████╗   ██║       ██║  ██║██║ ╚████║██║  ██║╚██████╔╝██║  ██║██║  ██║██║ ╚═╝ ██║███████║
╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝       ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝
".colorize(color: :yellow, mode: :blink) + " \nBy: Albert Carreras, Steven Chen, Ledio Bode".colorize(color: :magenta)
puts "\nThe player is given a randomly generated 9-letter string. The player is then given 25 seconds to find as many words as they can. They are given 1 point for each letter in the word they found (NOTE: Words can only be more than one letter). Have fun and check out the scoreboard for the top scores!"

#game start
menu
