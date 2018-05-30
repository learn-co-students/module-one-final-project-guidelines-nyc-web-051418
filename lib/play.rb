def save_player(player_name)
  $new_player = User.create(name: player_name)
end

def create_new_random_string
  vowels = %w[A E I O U]
  consonants = %w[B C D F G H J K L M N P Q R S T V W X Y Z]
  random_char_array = []
  4.times do
    random_char_array << consonants.sample
  end
  1.times do
    random_char_array << vowels.sample
  end
  random_char_array.sort.join
end

def api_call(new_random_string)
  api_data = RestClient.get("http://www.anagramica.com/all/\:#{new_random_string}")
  JSON.parse(api_data)['all'].select { |word| word.length > 1 }
end

def get_anagram_array_from_api
  new_random_string = create_new_random_string
  anagram_array = api_call(new_random_string)
  if anagram_array.any?

    puts "Your letters are: #{new_random_string.split('').join(' ')}".colorize(color: :black, background: :yellow)

    puts "These letters have #{anagram_array.length} crazy anagrams!".colorize(color: :black, background: :yellow)

    $new_word = Word.create(word: new_random_string, max_score: anagram_array.length)
  end
  anagram_array
end

def get_valid_anagram_array_from_api
  var = []
  var = get_anagram_array_from_api until var.any?
  var
end

def play_game
  anagram_array = get_valid_anagram_array_from_api
  varlong = []
  # begin
  #   result = Timeout::timeout(60) do
  #     loop do
  #       var = gets.chomp
  #       if $anagram_array.include?(var)
  #         $varlong << var
  #         puts "Correct!"
  #       else puts "Not an anagram!"
  #       end
  #     end
  #   end
  #   puts $varlong
  # rescue Timeout::Error
  #   puts "Your time is over! You found #{$varlong.length} anagrams. "
  # end

  start_time = Time.now
  until Time.now > (start_time + 10)
    var = gets.chomp
    if anagram_array.include?(var)
      varlong << var
      puts 'Correct!'.colorize(color: :black, background: :yellow)
    else puts 'Not an anagram!'.colorize(color: :black, background: :yellow)
    end
  end

  puts "You found #{varlong.length} crazy anagrams. That's awesome! Score = #{varlong.length} crazy points!".colorize(color: :black, background: :yellow)

  new_game = Game.create(user: $new_player, word: $new_word, score: varlong.length)

  puts 'Your game was saved!'

  play_again
end
