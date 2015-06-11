class Puzzle < ActiveRecord::Base

  def answer
    population[answer_id]
  end

end
