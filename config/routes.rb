Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "questions#top"

  get 'questions/top', to: 'questions#top'
  get 'questions/game', to: 'questions#game'
  get 'questions/gameover', to: 'questions#gameover'
end
