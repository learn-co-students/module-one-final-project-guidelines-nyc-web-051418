class User < ActiveRecord::Base
  has_many :highscores
  has_many :answers, through: :questions
  has_many :questions

  # creates new user if name entered by user does not exist in database
  def self.name_check(name)
    user_check = self.find_by(name: name)
    if user_check == nil
      user_check = self.create(name: name)
    end
    user_check
  end
end
