class Puzzle < ActiveRecord::Base

private

  def cache_answer
    ANSWERS_CACHE[id] = answer
  end

end
