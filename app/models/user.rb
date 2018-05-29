class User < ActiveRecord::Base
  def self.name_check(name)
    # check = self.find_by("name = ?",name)
    # if check == nil
    #   self.create(name: name)
    # end
    binding.pry
  end
end
