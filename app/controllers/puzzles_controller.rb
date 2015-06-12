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
    if PuzzleSolution.attempt params.slice(:puzzle_id, :answer_id)
      head :ok
    else
      head :not_found
    end
  end

  def query
    if PuzzleSolution.query puzzle_id: params[:puzzle_id], query_attrs: request.query_parameters
      head :ok
    else
      head :not_found
    end
  end

end
