class BoardsController < ApplicationController

  respond_to :json

  def new
    @board = BoardCreation.perform params[:team], params[:size]
    respond_with @board
  rescue Population::SizeError => e
    render json: e.message, status: :bad_request
  end

  def show
    @board = Board.find params[:id]
    respond_with @board
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

end
