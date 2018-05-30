class Stats < ActiveRecord::Base
  def self.call_stats(user)
    # Category Stats
    category_hash = Question.where(user_id: user.id).group(:category).count
    category_hash = category_hash.sort_by { |category, count| count}.reverse

    table = TTY::Table.new ['Category','Count'], category_hash
    puts table.render(:ascii)

    # Difficulty Stats
    difficulty_hash = Question.where(user_id: user.id).group(:difficulty).count
    difficulty_hash = difficulty_hash.sort_by { |difficulty, count| count}.reverse

    table = TTY::Table.new ['Difficulty','Count'], difficulty_hash
    puts table.render(:ascii)

    # Number of questions answered
    puts "Number of questions answered: #{user.answered}"
    puts "Percentage correct: #{100*user.correct/user.answered}%"

    # Percentage correct
    # binding.pry
  end
end