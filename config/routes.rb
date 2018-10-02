Rails.application.routes.draw do
  use_doorkeeper
  mount ActionCable.server => '/cable'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  concern :commented do
    resources :comments
  end

  resources :questions, concerns: :commented, shallow: true do
    resources :answers, concerns: :commented
  end

  namespace :api do
    namespace :v1 do
      resource :profiles do
        get :me, on: :collection
      end
      resource :questions
    end
  end

  root to: 'questions#index'
  get '/questions/:id/favorite/:favorite_answer' => 'questions#favorite'
  get '/questions/:question_id/answers/:id/up' => 'answers#rating_up'
  get '/questions/:question_id/answers/:id/down' => 'answers#rating_down'
end
