require_relative '../app/models/user.rb'

prompt = TTY::Prompt.new
pastel = Pastel.new
font = TTY::Font.new(:starwars)

trivia = RestClient.get('https://opentdb.com/api.php?amount=10&category=22&difficulty=easy')
trivia_hash = JSON.parse(trivia)

puts pastel.yellow(font.write("Pub Quiz"))
name = prompt.ask('What is your username?')
User.name_check(name)



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
