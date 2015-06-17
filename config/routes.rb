Rails.application.routes.draw do

  resources :boards, only: [:show, :destroy], defaults: { format: :json } do
    collection do
      get ":team/new" => 'boards#new'
    end

    get "person/:answer_id" => 'boards#answer'
    get "person" => 'boards#query'
  end

  get 'scoreboard' => 'scoreboard#show'
  root to: 'scoreboard#show'
end
