require_relative '../app/models/user.rb'
require_relative 'game_method.rb'

prompt = TTY::Prompt.new
pastel = Pastel.new
font = TTY::Font.new(:starwars)



# App Title
puts pastel.yellow(font.write("Pub Quiz"))

# The user is prompted to enter their username. The database is called to check if the name exists. If it doesn't then a new user is added to the database.
name = prompt.ask('What is your username?')
user = User.name_check(name)
puts "Welcome, #{user.name}!"

initial_menu = prompt.select("What would you like to do?",["Play", "High Scores", "Change Settings"])
  if initial_menu == "Play"
    game_method
  elsif initial_menu == "High Scores"
    puts "display high score table"
  else
    puts "allow user to change default settings"
  end

# User selects category and difficulty
# category_hash = {
#   "General knowledge" => 9,
#   "Books" => 10,
#   "Film" => 11,
#   "Music" => 12,
#   "Television" => 14,
#   "Science: Computers" => 18,
#   "Sports" => 21,
#   "History" => 23,
#   "Celebrities" => 26,
#   "Geography" => 22
# }
#
# category = prompt.select("Pick a category",[category_hash.keys])
# difficulty = prompt.select("Choose your difficulty level",["easy","medium","hard"])
# num_questions = prompt.ask("Choose your number of questions")
#
#
# # Call up the Trivia API
# url = "https://opentdb.com/api.php?amount=#{num_questions}&category=#{category_hash[category]}&difficulty=#{difficulty}"
# # binding.pry
# trivia = RestClient.get(url)
# trivia_hash = JSON.parse(trivia)
#
#
#
# score = 0
# trivia_hash["results"].each do |question|
#   answers = [] << question["correct_answer"]
#   answers << question["incorrect_answers"]
#   answers.flatten
#   answers = answers.shuffle
#   answer = prompt.select(question["question"], [answers])
#   if answer == question["correct_answer"]
#     puts pastel.black.on_bright_green('Correct')
#     score += 1
#   else
#     puts pastel.black.on_red("False")
#   end
#   puts "Score = #{score}"
# end
