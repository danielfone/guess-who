require 'rails_helper'

RSpec.describe 'GET /boards/[id]/person/[params]' do

  let!(:board) do
    create :board, {
      team: 'blue',
      answer: {
        hair: 'black',
        eyes: 'blue',
      }
    }
  end

  context 'with correct params' do
    it 'should respond with 200' do
      get "/boards/#{board.id}/person?eyes=green&hair=black"
      expect(response.status).to eq 200
    end
  end

  context 'with incorrect params' do
    it 'should 204' do
      get "/boards/#{board.id}/person?eyes=green&hair=brown"
      expect(response.status).to eq 204
    end
  end

  context 'with invalid params' do
    it 'should 400' do
      get "/boards/#{board.id}/person?foo=bar"
      expect(response.status).to eq 400
    end
  end


end
