Rails.application.routes.draw do
  get "/puzzles/:team/new" => 'puzzles#new', defaults: { format: :json }

  resources :puzzles, only: :show, defaults: { format: :json }
end
