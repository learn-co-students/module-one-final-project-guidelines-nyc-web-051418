class Answer < ActiveRecord::Base
  has_many :users, through: :questions
  has_many :questions
  

end
