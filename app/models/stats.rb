class Stats < ActiveRecord::Base
  def self.call_stats(user)
    puts "\n \n"
    # Joined User -> Answers table
    user_answers = User.joins(:answers).select('questions.*,answers.*').where("users.id = ?",user.id)

    # Category Stats
    category_hash = Question.where(user_id: user.id).group(:category).count
    category_hash = category_hash.sort_by { |category, count| count}.reverse
    table = TTY::Table.new ['Category','Count'], category_hash
    puts table.render(:ascii)
    puts "\n \n"

    # Difficulty Stats
    difficulty_hash = Question.where(user_id: user.id).group(:difficulty).count
    difficulty_hash = difficulty_hash.sort_by { |difficulty, count| count}.reverse

    table = TTY::Table.new ['Difficulty','Count'], difficulty_hash
    puts table.render(:ascii)
    puts "\n \n"

    # Number of questions answered & Percentage Correct
    correct_answers = user_answers.where("correct = 't'").count(:correct)
    total_answers = user_answers.count(:correct)
    puts "Number of questions answered: #{total_answers}"
    puts "\n \n"
    if total_answers == 0
      puts "You havent answered any questions!"
    else
      puts "Percentage of correct answers: #{100*correct_answers/total_answers}%"
    end
    puts "\n \n"

    # Find the longest streak
    streak = 0
    counter = 0
    user_answers.each do |answer|
      if answer.correct == "t"
        counter += 1
      else
        if counter > streak
          streak = counter
        end
        counter = 0
      end
    end
    puts "Longest streak: #{streak}"
    puts "\n \n"
  end


  def self.clear_stats(user)
    prompt = TTY::Prompt.new
    are_you_sure = prompt.select("Are you sure you want to delete statistics?",["No", "Yes"])
      if are_you_sure == "Yes"
        User.destroy(user.id)
        Question.where(user_id: user.id).destroy_all
        Highscore.where(user_id: user.id).destroy_all
        puts "Deleted!"
        return_to_menu
      else
        return_to_menu
      end
  end

end
