#this file holds all the methods related to the game logic.

def gets_timed_input(game, anagram_array)
  varlong = []
  begin
    result = Timeout::timeout(Game.time_settings) do
      loop do
        var = gets.downcase.chomp
        if anagram_array.include?(var)
          anagram_array.delete(var)
          varlong << var
          puts "Correct! #{var.length} points! #{anagram_array.length} left! #{Word.last[:word]}".colorize(color: :black, background: :yellow)
        else puts "Not an anagram! >> #{Word.last[:word]}".colorize(color: :black, background: :yellow)
        end
      end
    end
  rescue Timeout::Error
    puts "\nYour time is over!".colorize(color: :black, background: :yellow)
  end
  game_response(game, varlong, anagram_array)
end

def play_game(game)
  anagram_array = validate_anagram_array_from_api(game)
  puts "#{anagram_array.length} anagrams left!"
  gets_timed_input(game, anagram_array)
end

def get_score(array)
  array.inject(0) { |sum, n| sum + n.length }
end

def game_response(game, varlong, anagram_array)
  if varlong.length == 0
    puts "You found none crazy anagrams. Try again!\n".colorize(color: :black, background: :yellow).blink
    sleep(2)
  else
    score = get_score(varlong)
    puts "You found #{varlong.length} crazy anagrams. That's awesome!\nYou missed #{anagram_array.join(", ")}".colorize(color: :black, background: :yellow)
    puts "\nScore = #{score} crazy points!\nYour score succesfully was saved. Check the scoreboard!".colorize(color: :black, background: :yellow).blink
    User.find_or_create_player
    Game.save_game(score)
    sleep(4)
  end
  play_again(game)
end
