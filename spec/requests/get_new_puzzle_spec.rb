require 'rails_helper'

RSpec.describe 'GET /puzzles/[team]/new' do

  it 'should respond with correct JSON' do
    get "/puzzles/red-team/new?size=5"
    expect(response.code).to eq "200"
    expect(parsed_response).to include "id", "size", "population"
    expect(parsed_response['size']).to eq 5
  end

  context 'with bad params' do
    it 'should 404' do
      get "/puzzles/red-team/new?size=afdsaf"
      expect(response.status).to eq 400
    end
  end
end
