class CreateAnswersTable < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.integer :question_id
      t.boolean :correct?
    end
  end
end
