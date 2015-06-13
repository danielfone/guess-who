require 'rails_helper'

RSpec.describe 'GET /boards/[id]/person/[answer]' do

  let!(:board) do
    create :board, {
      team: 'blue',
      answer: {id: 123},
    }
  end

  context 'with correct person' do
    it 'should respond with 200' do
      get "/boards/#{board.id}/person/123"
      expect(response.status).to eq 200
    end
  end

  context 'with incorrect person' do
    it 'should 204' do
      get "/boards/#{board.id}/person/1"
      expect(response.status).to eq 204
    end
  end

  context 'with invalid person' do
    it 'should 400' do
      get "/boards/#{board.id}/person/xxx"
      expect(response.status).to eq 400
    end
  end


end
