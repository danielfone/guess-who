class BoardsController < ApplicationController

  def new
    @board = board_creation.perform
    @board.population = @board_creation.generated_population
    render json: board_json
  rescue Population::SizeError => e
    render json: e.message, status: :bad_request
  end

  def show
    @board = Board.find params[:id]
    render json: board_json
  end

  def answer
    head guess_correct? ? :ok : :no_content
  rescue ArgumentError
    render text: "Invalid answer", status: :bad_request
  end

  def query
    head matches? ? :ok : :no_content
  rescue KeyError => e
    render text: "Invalid key: #{e.message}", status: :bad_request
  end

private

  def solution
    @solution ||= BoardSolution.new params[:board_id]
  end

  def guess_correct?
    solution.guess params[:answer_id]
  end

  def matches?
    solution.ask request.query_parameters
  end

  def board_json
    @board.to_json(only: [:id, :size, :population, :team])
  end

  def board_creation
    @board_creation ||= BoardCreation.new params[:team], params[:size]
  end

end
