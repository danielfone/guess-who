require 'rails_helper'

RSpec.describe 'GET /puzzles/[id]/person/[answer]' do

  let!(:puzzle) do
    create :puzzle, {
      team: 'blue',
      answer: {id: 123},
    }
  end

  context 'with correct person' do
    it 'should respond with 200' do
      get "/puzzles/#{puzzle.id}/person/123"
      expect(response.status).to eq 200
    end
  end

  context 'with incorrect person' do
    it 'should 204' do
      get "/puzzles/#{puzzle.id}/person/1"
      expect(response.status).to eq 204
    end
  end

  context 'with invalid person' do
    it 'should 400' do
      get "/puzzles/#{puzzle.id}/person/xxx"
      expect(response.status).to eq 400
    end
  end


end
