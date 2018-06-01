class CreateDrinks < ActiveRecord::Migration[4.2]
  def change
    create_table :drinks do |t|
      t.string :api_id
      t.string :name
      t.string :category
      t.string :iba
      t.string :glass
      t.string :instructions
    end
  end
end
