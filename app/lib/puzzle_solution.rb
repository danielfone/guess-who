class PuzzleSolution < Struct.new(:puzzle_id)

  def guess(answer_id)
    mark_solved if check_answer['id'] == answer_id
  end

  def ask(attrs)
    attrs.any? { |k,v| check_answer[k] == v }
  end

private

  def check_answer
    @check_answer ||= begin
      Puzzle.increment_counter :guesses, puzzle_id
      Puzzle::ANSWERS_CACHE[puzzle_id] or raise_wrong!
    end
  end

  def mark_solved
    Puzzle.where(id: puzzle_id).update_all solved: true
    Puzzle::ANSWERS_CACHE.delete puzzle_id
  end

end
