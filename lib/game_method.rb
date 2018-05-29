require_relative '../app/models/user.rb'
require_relative '../app/models/highscores.rb'




def game_method(user)
  prompt = TTY::Prompt.new
  pastel = Pastel.new
  font = TTY::Font.new(:starwars)
  # User selects category and difficulty
  category_hash = {
    "General knowledge" => 9,
    "Books" => 10,
    "Film" => 11,
    "Music" => 12,
    "Television" => 14,
    "Science: Computers" => 18,
    "Sports" => 21,
    "History" => 23,
    "Celebrities" => 26,
    "Geography" => 22
  }

  category = prompt.select("Pick a category",[category_hash.keys])
  difficulty = prompt.select("Choose your difficulty level",["easy","medium","hard"])
  num_questions = prompt.ask("Choose your number of questions").to_i


  # Call up the Trivia API
  url = "https://opentdb.com/api.php?amount=#{num_questions}&category=#{category_hash[category]}&difficulty=#{difficulty}"
  # binding.pry
  trivia = RestClient.get(url)
  trivia_hash = JSON.parse(trivia)



  score = 0
  trivia_hash["results"].each do |question|
    answers = [] << question["correct_answer"]
    answers << question["incorrect_answers"]
    answers.flatten
    answers = answers.shuffle
    answer = prompt.select(question["question"], [answers])
    if answer == question["correct_answer"]
      puts pastel.black.on_bright_green('Correct')
      score += 1
    else
      puts pastel.black.on_red("False")
    end
    puts "Score = #{score}"
  end
  Highscore.save_score(score,user,num_questions)
  Highscore.show_scores
end
