class ChangeCorrect < ActiveRecord::Migration[5.0]
  def change
    rename_column :answers, :correct?, :correct
  end
end
