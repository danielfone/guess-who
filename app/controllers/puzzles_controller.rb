class PuzzlesController < ApplicationController

  respond_to :json

  def new
    @puzzle = PuzzleCreation.perform params[:team], params[:difficulty]
    respond_with @puzzle
  end

  def show
    @puzzle = Puzzle.find params[:id]
    respond_with @puzzle
  end

  def answer
    head guess_correct? ? :ok : :not_found
  end

  def query
    head matches? ? :ok : :not_found
  end

private

  def solution
    @solution ||= PuzzleSolution.new params[:puzzle_id]
  end

  def guess_correct?
    solution.guess params[:answer_id]
  end

  def matches?
    solution.ask request.query_parameters
  end

end
