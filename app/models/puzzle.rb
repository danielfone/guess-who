class Puzzle < ActiveRecord::Base
  ANSWERS_CACHE = {}
  after_save :cache_answer

private

  def cache_answer
    ANSWERS_CACHE[id] = answer
  end

end
