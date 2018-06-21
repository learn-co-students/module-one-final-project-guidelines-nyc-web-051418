class CreateQuestionsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.integer :user_id
      t.string :category
      t.string :difficulty
      t.string :question
    end
  end
end
