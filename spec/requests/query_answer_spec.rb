require 'rails_helper'

RSpec.describe 'GET /puzzles/[id]/person/[params]' do

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
      get "/puzzles/#{puzzle.id}/person?eyes=green&hair=black"
      expect(response.status).to eq 200
    end
  end

  context 'with incorrect params' do
    it 'should 204' do
      get "/puzzles/#{puzzle.id}/person?eyes=green&hair=brown"
      expect(response.status).to eq 204
    end
  end

  context 'with invalid params' do
    it 'should 400' do
      get "/puzzles/#{puzzle.id}/person?foo=bar"
      expect(response.status).to eq 400
    end
  end


end
