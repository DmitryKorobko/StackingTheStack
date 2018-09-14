Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  devise_for :users

  resources :questions do
    resources :answers
  end

  root to: 'questions#index'
  get '/questions/:id/favorite/:favorite_answer' => 'questions#favorite'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
