
def game_method(user)
  # Game formatting
  prompt = TTY::Prompt.new
  pastel = Pastel.new
  font = TTY::Font.new(:starwars)


  # User selects category, difficulty, and number of questions (defaults to 10 if 0 is entered)
    # category_hash defines a category name by its corresponding number that gets parsed into API URL
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
  num_questions = prompt.ask("Choose your number of questions", default: 10).to_i


  # Call up the Trivia API using data retrieved from user
  url = "https://opentdb.com/api.php?amount=#{num_questions}&category=#{category_hash[category]}&difficulty=#{difficulty}"
  trivia = RestClient.get(url)
  trivia_hash = JSON.parse(trivia)


  # GAME PLAY
  score = 0
  trivia_hash["results"].each do |question|

    #reformats symbols to be readable in command line
    coder = HTMLEntities.new
    correct_answer = coder.decode(question["correct_answer"])
    incorrect_answers = question["incorrect_answers"].map do |answer|
      coder.decode(answer)
    end
    questions = coder.decode(question["question"])


    # stores questions in questions table
    quest = Question.create(user_id: user.id, category: category, difficulty: difficulty, question: questions)

    # lists answers in a randomized, multiple-choice format
    answers = [] << correct_answer
    answers << incorrect_answers
    answers.flatten
    answers = answers.shuffle

    # display question and answers to user
    answer = prompt.select(questions, [answers])



    # answering and scoring functionality
    # CORRECT ANSWER
    if answer == correct_answer
      puts pastel.black.on_bright_green('Correct')

      # Increases current user score by 1
      score += 1

      #stores data in questions and answers tables
      Answer.create(question_id: Question.last.id, correct: true)
      quest.update(answer_id: Answer.last.id)


    # INCORRECT ANSWER
    else
      puts pastel.black.on_red("False-- Correct answer is #{correct_answer}")

      #stores data in questions and answers tables
      Answer.create(question_id: Question.last.id, correct: false)
      quest.update(answer_id: Answer.last.id)
    end

    # displays score after each question is answered
    puts "Score = #{score}"
  end


  # saves score and displays high scores at end of game
  Highscore.save_score(score,user,num_questions)
  Highscore.show_scores
  return_to_menu
end
