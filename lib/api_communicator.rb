def create_new_random_string
  vowels = %w[A E I O U]
  consonants = %w[B C D F G H J K L M N P Q R S T V W X Y Z]
  random_char_array = []
  4.times do
    random_char_array << consonants.sample
  end
  5.times do
    random_char_array << vowels.sample
  end
  random_char_array.sort.join
end

def get_word_association
  var = PROMPT.collect do
  key(:idea1).ask('Crazy Word 1:', default: " ")
  key(:idea2).ask('Crazy Word 2:', default: " ")
  end
  var
end

def api_call_association
valid_array = []
  until valid_array != []
    puts "Please, enter 2 valid Crazy words of your choice!"
    association = get_word_association
    word1 = association[:idea1].delete(' ')
    word2 = association[:idea2].delete(' ')
    api_data = RestClient.get("https://api.datamuse.com/words?rel_jjb=#{word1}\&topics\=#{word2}")
    valid_array = JSON.parse(api_data)
  end
  array = valid_array.select { |instance| instance["word"].length.between?(5, 9)}
  array.first["word"]
end

def api_call_anagrams(new_random_string)
  api_data = RestClient.get("http://www.anagramica.com/all/\:#{new_random_string}")
  var = JSON.parse(api_data)['all'].select { |word| word.length > 1 }
  var.delete(new_random_string)
  var
end

def get_anagram_array_from_api(game)
  if game == "letters"
    new_random_string = create_new_random_string
  elsif game == "associations"
    new_random_string = api_call_association
  end

  anagram_array = api_call_anagrams(new_random_string)

  if anagram_array.any?

    puts "Your letters are: #{new_random_string.split('').join(' ')}".colorize(color: :black, background: :yellow)

    puts "These letters have #{anagram_array.length} crazy anagrams!".colorize(color: :black, background: :yellow)

    Word.create_word(new_random_string, get_score(anagram_array))

  end
  anagram_array
end

def validate_anagram_array_from_api(game)
  var = []
  var = get_anagram_array_from_api(game) until var.any?
  var
end
