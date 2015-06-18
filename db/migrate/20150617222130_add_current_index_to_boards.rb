class AddCurrentIndexToBoards < ActiveRecord::Migration
  def change
    add_index :boards, [:round, :solved]
    add_index :boards, [:created_at, :solved]
  end
end
