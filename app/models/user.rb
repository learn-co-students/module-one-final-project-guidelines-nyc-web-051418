class User < ActiveRecord::Base
  def self.name_check(name)
    user_check = self.find_by(name: name)
    if user_check == nil
      user_check = self.create(name: name)
    end
    user_check
    # binding.pry
  end



end
