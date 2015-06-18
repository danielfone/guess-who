require 'rails_helper'

RSpec.describe 'GET /boards/[id]' do

  let!(:board) do
    create :board, {
      team: 'blue',
      population: {foo: 'bar'}
    }
  end

  it 'should respond with correct JSON' do
    get "/boards/#{board.id}"
    expect(parsed_response).to include "id", "size", "population"
    expect(parsed_response['team']).to eq 'blue'
    expect(parsed_response['population']).to eq nil
  end

end
