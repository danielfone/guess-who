require 'rails_helper'

RSpec.describe 'GET /puzzles/[id]/answer/[answer]' do

  let!(:puzzle) do
    create :puzzle, {
      team: 'blue',
      answer_id: '123',
    }
  end

  context 'with correct answer' do
    it 'should respond with correct JSON' do
      get "/puzzles/#{puzzle.id}/answer/123"
      expect(response).to be_successful
      expect(parsed_response["solved"]).to eq true
      expect(parsed_response["guesses"]).to eq 1
    end
  end

  context 'with incorrect answer' do
    it 'should respond with correct JSON' do
      expect {
        get "/puzzles/#{puzzle.id}/answer/xxx"
      }.to raise_error ActiveRecord::RecordNotFound
    end
  end

end
