require 'rails_helper'

RSpec.describe 'GET /puzzles/[id]/answer/[params]' do

  let!(:puzzle) do
    create :puzzle, {
      team: 'blue',
      answer: {
        hair: 'black',
        eyes: 'blue',
      }
    }
  end

  context 'with correct params' do
    it 'should respond with 200' do
      get "/puzzles/#{puzzle.id}/answer?eyes=green&hair=black"
      expect(response).to be_successful
    end
  end

  context 'with incorrect params' do
    it 'should 404' do
      get "/puzzles/#{puzzle.id}/answer?eyes=green&hair=brown"
      expect(response).to be_not_found
    end
  end

end
