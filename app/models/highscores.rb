class Highscore < ActiveRecord::Base
  def self.save_score(score,user,num_questions)
    # user_id.find_by(user.id)
    # self.create(user_id: user.id, total_points: score,questions_answered: num_questions,percentage_correct: 100*score/num_questions)
    binding.pry
  end




end
