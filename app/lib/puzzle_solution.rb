class PuzzleSolution < Struct.new(:puzzle_id)

  def guess(answer_id)
    mark_solved if check_answer['id'] == Integer(answer_id)
  end

  def ask(attrs)
    attrs.any? { |k,v| check_answer.fetch(k) == v }
  end

private

  def check_answer
    @check_answer ||= begin
      Puzzle.increment_counter :guesses, puzzle_id
      cache.fetch ["answers", puzzle_id] do
        Puzzle.find(puzzle_id).answer
      end
    end
  end

  def mark_solved
    Puzzle.where(id: puzzle_id).update_all solved: true
  end

  def cache
    Rails.cache
  end

end
