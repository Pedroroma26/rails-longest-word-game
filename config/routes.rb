Rails.application.routes.draw do
  # Generic syntax:
  # verb "path", to: "controller#action"
  get 'new', to: 'games#new'
  post 'score', to: 'games#score'
end
