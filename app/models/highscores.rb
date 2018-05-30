class Highscore < ActiveRecord::Base
  belongs_to :user

  def self.save_score(score,user,num_questions)
    self.create(user_id: user.id, total_points: score,questions_answered: num_questions,percentage_correct: 100*score/num_questions)
  end

  def self.show_scores
    score_hash = Highscore.group(:user_id).sum(:total_points)
    player_score_hash = {}
    score_hash.each do |user_id, score|
      user = User.find_by(id: user_id)
      player_score_hash[user.name] = score
    end

    sorted_hash = player_score_hash.sort_by { |user, score| score}.reverse

    # Generates a table of high scores
    table = TTY::Table.new ['Name','Score'], sorted_hash
    puts table.render(:ascii)
  end



end
