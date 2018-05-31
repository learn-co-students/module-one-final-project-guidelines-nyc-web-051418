require_relative '../config/environment'

def play_game(user = User.current_user)
  anagram_array = []
  anagram_array = get_anagram_array_from_api until anagram_array.any? == true
  score = 0
  begin
    Timeout.timeout 20 do
      loop do
        ans = gets.chomp
        if anagram_array.include?(ans.downcase) == true
          anagram_array.delete(ans)
          score += ans.length
          puts "\nGreat! You get #{score} points\n".colorize(color: :magenta)
        else
          puts "\nOops...that word is not an anagram. Please try another word.\n".colorize(color: :red)
          end
      end
      score
    end
  rescue Timeout::Error
    puts "\nSorry,you are out of time! You got #{score} points!".colorize(color: :magenta, mode: :blink)
    puts "\nYou missed these words!" + " \n#{anagram_array.join(", ")}".colorize(color: :magenta, mode: :bold)
    sleep(3)
  end
  Game.create(user: user, word: Word.last, score: score)
  play_again
end

def play_again
  user_select = PROMPT.select("\nWhat do want to do?", %w[Play\ again Scoreboard Quit])
  if user_select == 'Play again'
    play_game
  elsif user_select == 'Scoreboard'
    scorecard
  elsif user_select == 'Quit'
    puts 'Bye!'
  end
end

def scorecard
  rows = []
  Game.all.sort { |x, y| y[:score] <=> x[:score] }[0..14].each do |game|
    rows << [game.user.id, game.user.name, game.word.word, game.score]
  end
  table = Terminal::Table.new title: "SCOREBOARD - TOP 15".colorize(color: :magenta, mode: :blink), headings: ["Player ID".colorize(color: :magenta, mode: :bold), "Username".colorize(color: :magenta, mode: :bold), "Letters".colorize(color: :magenta, mode: :bold), "Score".colorize(color: :magenta, mode: :bold)], rows: rows, style: {width: 80, padding_left: 3, border_x: "=", border_i: "x" }
    puts table
  menu
end
