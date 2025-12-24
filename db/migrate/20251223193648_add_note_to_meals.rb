class AddNoteToMeals < ActiveRecord::Migration[8.1]
  def change
    add_column :meals, :note, :string
  end
end
