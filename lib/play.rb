
def play_game(user=User.current_user)
  anagram_array = []
    until anagram_array.any? == true
      anagram_array = get_anagram_array_from_api
    end
  score = 0
  begin
    Timeout::timeout 20 do
    loop do
      ans = gets.chomp
        if anagram_array.include?(ans.downcase) ==true
          anagram_array.delete(ans)
          score+=ans.length
            puts "Great! You get #{score} points"
          else
            puts "Oops...that word is not an anagram. Please try another word."
          end
        end
     score
    end
    rescue Timeout::Error
     puts "\nSorry,you are out of time! You got #{score} points!"
  end
  Game.create(user: user, word: Word.last, score: score)
  play_again
end

def play_again
  prompt = TTY::Prompt.new
  user_select = prompt.select("What do want to do?", %w(Play\ again Scoreboard Quit))
  if user_select == "Play again"
    play_game
  elsif user_select == "Scoreboard"
    scorecard
  elsif user_select == "Quit"
    puts "Bye!"
  end
end

def scorecard
rows=[]
  Game.all.sort {|x,y| y[:score] <=>x[:score]}[0..15].each do |game|
    rows << [game.user.id, game.user.name, game.word.word, game.score]
  end
  table=Terminal::Table.new :title =>"Scoreboard", :headings => ["Player ID", "Username","Letters","Score"], :rows => rows, :style =>{:width => 80, :padding_left => 3, :border_x => "=", :border_i => "x"}
  puts table
  menu
end
