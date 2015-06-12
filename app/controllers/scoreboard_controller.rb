class ScoreboardController < ApplicationController

  def show
    @scoreboard = Scoreboard.new
  end

end
