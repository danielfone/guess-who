class PuzzleSolution
  include ActiveModel::Model

  attr_accessor :puzzle_id, :answer_id, :query_attrs

  def self.query(*args); new(*args).query; end
  def self.attempt(*args); new(*args).attempt; end

  def attempt
    raise_wrong! unless check_answer['id'] == answer_id
    puzzle.update_column :solved, true
    puzzle
  end

  def query
    raise_wrong! unless query_attrs.any? { |k,v| check_answer[k] == v }
    puzzle
  end

private

  def puzzle
    @puzzle ||= Puzzle.find puzzle_id
  end

  def check_answer
    @answer ||= begin
      Puzzle.increment_counter :guesses, puzzle_id
      puzzle.answer
    end
  end

  def raise_wrong!
    raise ActiveRecord::RecordNotFound
  end

end
