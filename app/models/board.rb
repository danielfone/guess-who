class Board < ActiveRecord::Base
  attr_accessor :population

  def self.active(team)
    where(team: team, solved: false).first
  end

  def as_json(*args)
    {
      'id' => id,
      'size' => size,
      'team' => team,
      'population' => population,
    }
  end

end
