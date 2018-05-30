class User < ActiveRecord::Base
  has_many :highscores
  has_many :answers, through: :questions
  has_many :questions
  

  def self.name_check(name)
    user_check = self.find_by(name: name)
    if user_check == nil
      user_check = self.create(name: name, answered: 0, correct: 0)
    end
    user_check
  end
end
