class Game < ActiveRecord::Base
  belongs_to :user
  belongs_to :word

  def self.ranking_per_user_score
    ranking = Game.all.sort_by {|instance| instance[:score]}.reverse
    rows = []
    i = 1
    ranking.take(10).each do |instance|
      rows << [i, instance.word[:word], instance.word[:max_score], instance[:score],instance.user[:name]]
      # puts "#{i}#\ String: #{instance.word[:word]} | Max_Score:#{instance.word[:max_score]} | User_Score:#{instance[:score]} | User:#{instance.user[:name]} "
      i+=1
    end
    puts Terminal::Table.new :headings => ['#', 'Letters', 'Max Score', 'User score', 'Player'], :rows => rows
    menu_option
  end

end
