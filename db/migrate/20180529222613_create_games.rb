class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :user_id
      t.integer :word_id
      t.integer :score
    end
  end
end
