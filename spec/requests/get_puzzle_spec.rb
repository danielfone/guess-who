require 'rails_helper'

RSpec.describe 'GET /puzzles/[id]' do

  let!(:puzzle) do
    create :puzzle, {
      team: 'blue',
      population: {foo: 'bar'}
    }
  end

  it 'should respond with correct JSON' do
    get "/puzzles/#{puzzle.id}"
    expect(parsed_response).to include "id", "difficulty", "population"
    expect(parsed_response['team']).to eq 'blue'
    expect(parsed_response['population']).to eq 'foo' => 'bar'
  end

end
