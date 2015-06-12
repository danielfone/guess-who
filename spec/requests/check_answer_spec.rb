require 'rails_helper'

RSpec.describe 'GET /puzzles/[id]/answer/[answer]' do

  let!(:puzzle) do
    create :puzzle, {
      team: 'blue',
      answer: {id: '123'},
    }
  end

  context 'with correct answer' do
    it 'should respond with 200' do
      get "/puzzles/#{puzzle.id}/answer/123"
      expect(response).to be_successful
    end
  end

  context 'with incorrect answer' do
    it 'should 404' do
      get "/puzzles/#{puzzle.id}/answer/xxx"
      expect(response).to be_not_found
    end
  end

end
