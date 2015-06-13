Rails.application.routes.draw do

  resources :puzzles, only: :show, defaults: { format: :json } do
    collection do
      get ":team/new" => 'puzzles#new'
    end

    get "person/:answer_id" => 'puzzles#answer'
    get "person" => 'puzzles#query'
  end

  get 'scoreboard' => 'scoreboard#show'
  root to: 'scoreboard#show'
end
