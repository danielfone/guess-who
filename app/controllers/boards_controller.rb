class BoardsController < ApplicationController

  def new
    @board = current_board || new_board
    render json: board_json
  rescue Population::SizeError => e
    render json: e.message.to_json, status: :bad_request
  end

  def show
    @board = Board.find params[:id]
    render json: board_json
  end

  def answer
    head guess_correct? ? :ok : :no_content
  rescue ArgumentError
    render json: "Invalid answer".to_json, status: :bad_request
  end

  def query
    head matches? ? :ok : :no_content
  rescue KeyError => e
    render json: "Invalid key: #{e.message}".to_json, status: :bad_request
  end

  def destroy
    @board = Board.find params[:id]
    @board.destroy
    head :ok
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
    @board.to_json(only: [:id, :size, :team], methods: :population)
  end

  def new_board
    BoardCreation.perform params[:team], params[:size]
  end

  def current_board
    Board.active(params[:team])
  end

end
