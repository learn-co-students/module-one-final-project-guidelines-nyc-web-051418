class Game < ActiveRecord::Base
  belongs_to :user
  belongs_to :word

@@time = 60

  def self.set_time_settings(seconds)
    @@time = seconds
  end

  def self.time_settings
    @@time
  end

  def self.save_game(score)
    Game.create(user: User.current_user, word: Word.last, score: score)
  end

  def self.ranking_per_user_score
    ranking = Game.all.sort_by {|instance| instance[:score]}.reverse
    rows = []
    i = 1
    ranking.take(10).each do |instance|
      rows << [i, instance.word[:word], instance.word[:max_score], instance[:score],instance.user[:name].capitalize]
      i+=1
    end
    puts " "
    puts Terminal::Table.new :title => "Top 10 - Scoreboard", :headings => ['#', 'Letters', 'Max Score', 'Player Score', 'Player'], :rows => rows
    puts " "
    menu_option
  end

  def self.get_best_user_score
    player_list = User.all
    var = player_list.map do |player|
      higher_score = player.games.max_by {|t| t[:score]}[:score]
      {player: player, highest_score: higher_score}
    end
    var2 = var.sort_by {|instance| instance[:highest_score]}.reverse
  end

  def self.ranking_best_user_score
    ranking = get_best_user_score
    rows = []
    i = 1
    ranking.take(10).each do |instance|
      rows << [i, instance[:player].name.capitalize, instance[:highest_score]]
      i+=1
    end
    puts Terminal::Table.new :title => "Best Player Score - Scoreboard", :headings => ['#', 'Player Name', 'Max Score'], :rows => rows
    menu_option
  end

end
