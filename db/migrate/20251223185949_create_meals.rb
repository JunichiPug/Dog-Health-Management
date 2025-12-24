class CreateMeals < ActiveRecord::Migration[8.1]
  def change
    create_table :meals do |t|
      t.string :name
      t.datetime :eaten_at

      t.timestamps
    end
  end
end
