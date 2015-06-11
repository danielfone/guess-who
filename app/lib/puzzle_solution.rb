class PuzzleSolution
  include ActiveModel::Model

  attr_accessor :puzzle_id, :answer_id, :query_attrs

  def self.query(*args); new(*args).query; end
  def self.attempt(*args); new(*args).attempt; end

  def attempt
    record_guess
    raise_wrong! unless puzzle.answer_id == answer_id
    puzzle.update_column :solved, true
    puzzle
  end

  def query
    record_guess
    raise_wrong! unless query_attrs.any? { |k,v| answer[k] == v }
    puzzle
  end

private

  def puzzle
    @puzzle ||= Puzzle.find puzzle_id
  end

  def answer
    @answer ||= puzzle.answer
  end

  def record_guess
    Puzzle.increment_counter :guesses, puzzle_id
  end

  def raise_wrong!
    raise ActiveRecord::RecordNotFound
  end

end
