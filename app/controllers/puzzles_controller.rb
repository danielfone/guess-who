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
    @puzzle = PuzzleSolution.attempt params[:puzzle_id], params[:answer_id]
    respond_with @puzzle
  end

private

  def puzzle_params
    params.slice(:team, :difficulty)
  end

end
