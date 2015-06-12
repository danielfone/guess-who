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
    if solution.guess params[:answer_id]
      head :ok
    else
      head :not_found
    end
  end

  def query
    if solution.ask request.query_parameters
      head :ok
    else
      head :not_found
    end
  end

private

  def solution
    @solution ||= PuzzleSolution.new params[:puzzle_id]
  end

end
