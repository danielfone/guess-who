class Board < ActiveRecord::Base

  def score
    solved? ? size / guesses : 0
  end

end
