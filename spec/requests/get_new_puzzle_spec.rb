require 'rails_helper'

RSpec.describe 'GET /puzzles/[team]/new' do

  it 'should respond with correct JSON' do
    get "/puzzles/red-team/new?difficulty=5"
    expect(response.code).to eq "200"
    expect(parsed_response).to include "id", "difficulty", "population"
    expect(parsed_response['difficulty']).to eq 5
  end

  context 'with bad params' do
    it 'should 404' do
      get "/puzzles/red-team/new?difficulty=afdsaf"
      expect(response).to be_not_found
    end
  end
end
