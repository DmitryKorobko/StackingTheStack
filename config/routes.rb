Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  devise_for :users

  concern :commented do
    resources :comments
  end

  resources :questions, concerns: :commented, shallow: true do
    resources :answers, concerns: :commented
  end

  root to: 'questions#index'
  get '/questions/:id/favorite/:favorite_answer' => 'questions#favorite'
  get '/questions/:question_id/answers/:id/up' => 'answers#rating_up'
  get '/questions/:question_id/answers/:id/down' => 'answers#rating_down'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
