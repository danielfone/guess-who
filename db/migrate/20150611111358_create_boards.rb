class CreateBoards < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'

    create_table :boards, id: :uuid do |t|
      t.integer :size
      t.string :team
      t.json :answer
      t.integer :guesses, null: false, default: 0
      t.boolean :solved, null: false, default: false
      t.integer :round, index: true
      t.datetime :created_at
    end
  end
end
