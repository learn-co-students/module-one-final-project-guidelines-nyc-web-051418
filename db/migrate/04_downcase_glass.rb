class DowncaseGlass < ActiveRecord::Migration[5.1]
  def up
    Drink.all.each do |drink|
      drink.update_attributes :glass => drink.glass.downcase
    end
  end
end
