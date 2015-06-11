class PuzzleSolution

  def self.attempt(*args); new(*args).attempt; end

  def initialize(puzzle_id, answer_id)
    @puzzle_id = puzzle_id
    @answer_id = answer_id
  end

  def attempt
    Puzzle.increment_counter :guesses, @puzzle_id
    raise ActiveRecord::RecordNotFound unless puzzle.answer_id == @answer_id
    puzzle.update_column :solved, true
    puzzle
  end

private

  def puzzle
    @puzzle ||= Puzzle.find @puzzle_id
  end

end
