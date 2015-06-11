require 'rails_helper'

RSpec.describe 'GET /puzzles/[id]/answer/[params]' do

  let!(:puzzle) do
    create :puzzle, {
      team: 'blue',
      answer_id: '123',
      population: {
        '123' => {
          hair: 'black',
          eyes: 'blue',
        }
      }
    }
  end

  context 'with correct params' do
    it 'should respond with correct JSON' do
      get "/puzzles/#{puzzle.id}/answer?eyes=green&hair=black"
      expect(response).to be_successful
      expect(parsed_response["guesses"]).to eq 1
    end
  end

  context 'with incorrect params' do
    it 'should 404' do
      expect {
        get "/puzzles/#{puzzle.id}/answer?eyes=green&hair=brown"
      }.to raise_error ActiveRecord::RecordNotFound
    end
  end

end
