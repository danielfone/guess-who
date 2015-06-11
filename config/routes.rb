Rails.application.routes.draw do
  get "/puzzles/:team/new" => 'puzzles#new'
end
