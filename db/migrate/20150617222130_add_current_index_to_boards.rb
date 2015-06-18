class AddCurrentIndexToBoards < ActiveRecord::Migration
  def change
    add_index :boards, :solved
    add_index :boards, :created_at
  end
end
