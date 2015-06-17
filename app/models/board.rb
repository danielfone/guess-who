class Board < ActiveRecord::Base

  def self.active(team)
    where(team: team, solved: false).first
  end

end
