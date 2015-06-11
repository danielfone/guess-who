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
    @puzzle = PuzzleSolution.attempt params.slice(:puzzle_id, :answer_id)
    respond_with @puzzle
  end

  def query
    @puzzle = PuzzleSolution.query puzzle_id: params[:puzzle_id], query_attrs: request.query_parameters
    respond_with @puzzle
  end

private

  def puzzle_params
    params.slice(:team, :difficulty)
  end

end
