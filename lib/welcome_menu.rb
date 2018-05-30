PROMPT = TTY::Prompt.new(active_color: :cyan)

def menu_option
  category = PROMPT.select('Choose your Crazy Anagram Game?', %w[Random\ letters Category\ words Scoreboard Quit])
  if category == 'Random letters'
      ready_response = PROMPT.yes?('You will have 60 seconds to find as many anagrams as you can.Ready?')
      play_game if ready_response == true
  elsif category == 'Scoreboard'
      Game.ranking_per_user_score
  elsif category == 'Quit'
    puts ColorizedString["THANK YOU!"].black.on_yellow.blink
  end
end

def play_again
  again_response = PROMPT.yes?('Wanna play again?')
  again_response == true ? play_game : menu_option
end

def start
  puts ColorizedString[
  "
  ╔═╗╦═╗╔═╗╔═╗╦ ╦  ╔═╗╔╗╔╔═╗╔═╗╦═╗╔═╗╔╦╗╔═╗
  ║  ╠╦╝╠═╣╔═╝╚╦╝  ╠═╣║║║╠═╣║ ╦╠╦╝╠═╣║║║╚═╗
  ╚═╝╩╚═╩ ╩╚═╝ ╩   ╩ ╩╝╚╝╩ ╩╚═╝╩╚═╩ ╩╩ ╩╚═╝"].blue.on_red.blink
  puts 'by Alberto Carreras'
  sleep(2)
  player_name = PROMPT.ask('What is your name?', default: ENV['USER'])
  save_player(player_name)
  menu_option
end
