class Puzzle < ActiveRecord::Base

  def score
    if solved?
      difficulty / guesses
    else
      -Math.log2(difficulty || 1)
    end
  end

end
