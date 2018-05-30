class AddColumnCorrectcount < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :answered, :integer
    add_column :users, :correct, :integer
  end
end
