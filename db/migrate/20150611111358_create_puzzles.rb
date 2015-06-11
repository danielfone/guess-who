class CreatePuzzles < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'

    create_table :puzzles, id: :uuid do |t|
      t.integer :difficulty
      t.string :team
      t.json :population
      t.json :answer
      t.integer :guesses, null: false, default: 0
      t.boolean :solved, null: false, default: false
    end
  end
end
