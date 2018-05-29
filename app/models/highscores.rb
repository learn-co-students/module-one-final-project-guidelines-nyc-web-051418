class Highscore < ActiveRecord::Base
  def self.save_score(score,user,num_questions)
    self.create(user_id: user.id, total_points: score,questions_answered: num_questions,percentage_correct: 100*score/num_questions)
    # binding.pry
  end

  def self.show_scores

    # sql = "SELECT user_id, sum(:total_points), sum(:questions_answered) FROM Highscore ORDER BY sum(:total_points) DESC;"
    # DB[:conn]
    score_hash = Highscore.group(:user_id).sum(:total_points)
    player_score_hash = {}
    score_hash.each do |user_id, score|

      user = User.find_by(id: user_id)
      player_score_hash[user.name] = score
    end
    sorted_hash = player_score_hash.sort_by { |user, score| score}.reverse
    counter = 1
    sorted_hash.each do |user, score|
      puts "#{counter}. #{user}: #{score}"
      counter += 1
    end
    # table = TTY::Table.new ['username', 'score'], #add rows later
  end



end
