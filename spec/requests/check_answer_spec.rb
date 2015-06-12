require 'rails_helper'

RSpec.describe 'GET /puzzles/[id]/answer/[answer]' do

  let!(:puzzle) do
    create :puzzle, {
      team: 'blue',
      answer: {id: 123},
    }
  end

  context 'with correct answer' do
    it 'should respond with 200' do
      get "/puzzles/#{puzzle.id}/answer/123"
      expect(response.status).to eq 200
    end
  end

  context 'with incorrect answer' do
    it 'should 204' do
      get "/puzzles/#{puzzle.id}/answer/1"
      expect(response.status).to eq 204
    end
  end

  context 'with invalid answer' do
    it 'should 400' do
      get "/puzzles/#{puzzle.id}/answer/xxx"
      expect(response.status).to eq 400
    end
  end


end
