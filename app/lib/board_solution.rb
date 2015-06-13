class BoardSolution < Struct.new(:board_id)

  def guess(answer_id)
    mark_solved if check_answer['id'] == Integer(answer_id)
  end

  def ask(attrs)
    attrs.any? { |k,v| check_answer.fetch(k) == v }
  end

private

  def check_answer
    @check_answer ||= begin
      Board.increment_counter :guesses, board_id
      cache.fetch ["answers", board_id] do
        # Don't load potentially huge `population` field
        Board.select(:answer).find(board_id).answer
      end
    end
  end

  def mark_solved
    Board.where(id: board_id).update_all solved: true
  end

  def cache
    Rails.cache
  end

end
