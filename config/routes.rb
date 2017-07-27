Rails.application.routes.draw do
  resources :votes
  resources :voters
  resources :proposals
  resources :polls
  resources :items
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
