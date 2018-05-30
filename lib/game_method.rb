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
  trivia = RestClient.get(url)
  trivia_hash = JSON.parse(trivia)


  score = 0
  trivia_hash["results"].each do |question|
    #reformats symbols to be readable
    coder = HTMLEntities.new
    correct_answer = coder.decode(question["correct_answer"])
    incorrect_answers = question["incorrect_answers"].map do |answer|
      coder.decode(answer)
    end
    questions = coder.decode(question["question"])
    #stores questions in questions table
    quest = Question.create(user_id: user.id, category: category, difficulty: difficulty, question: questions)

    answers = [] << correct_answer
    answers << incorrect_answers
    answers.flatten
    answers = answers.shuffle
    answer = prompt.select(questions, [answers])

    if answer == correct_answer
      puts pastel.black.on_bright_green('Correct')

      # Increases current user correct counter by 1
      score += 1

      #stores 'true' in answers table
      Answer.create(question_id: Question.last.id, correct: true)
      quest.update(answer_id: Answer.last.id)
    else
      puts pastel.black.on_red("False-- Correct answer is #{correct_answer}")
      #stores 'false' in answers table
      Answer.create(question_id: Question.last.id, correct: false)
      quest.update(answer_id: Answer.last.id)
    end
    puts "Score = #{score}"
  end
  Highscore.save_score(score,user,num_questions)
  Highscore.show_scores
  play_again = prompt.select("Would you like to play again?",["Yes", "No"])
  if play_again == "Yes"
    game_method(user)
  else puts "Goodbye!"
  end
end
