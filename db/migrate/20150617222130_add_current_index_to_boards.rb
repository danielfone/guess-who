class AddCurrentIndexToBoards < ActiveRecord::Migration
  def change
    add_index :boards, [:team, :solved]
  end
end
