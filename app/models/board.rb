class Board < ActiveRecord::Base

  def self.active(team)
    where(team: team, solved: false).first
  end

  def score
    solved? ? size / guesses : 0
  end

end
