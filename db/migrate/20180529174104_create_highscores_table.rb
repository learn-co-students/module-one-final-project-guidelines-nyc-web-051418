class CreateHighscoresTable < ActiveRecord::Migration[5.0]
  def change
    create_table :highscores do |t|
      t.integer :user_id, null: false
      t.integer :total_points
      t.integer :questions_answered
      t.float :percentage_correct
    end
  end
end
