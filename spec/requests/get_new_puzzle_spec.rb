require 'rails_helper'

RSpec.describe 'GET /puzzles/[team]/new' do

  it 'should respond with correct JSON' do
    get "/puzzles/red-team/new.json?difficulty=5"
    expect(parsed_response).to include "id", "difficulty", "population"
    expect(parsed_response['difficulty']).to eq 5
  end

  def parsed_response
    @parsed_response ||= JSON.parse response.body
  end

end
