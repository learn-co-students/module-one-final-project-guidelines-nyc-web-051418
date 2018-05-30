class Answer < ActiveRecord::Base
  has_many :users, through: :questions
  

end
