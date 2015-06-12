class Puzzle < ActiveRecord::Base

  def score
    if solved?
      size / guesses
    else
      -Math.log2(size || 1)
    end
  end

end
