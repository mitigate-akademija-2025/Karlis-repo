Rails.application.routes.draw do
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  root to: redirect('/quizzes')

  resources :quizzes do
    resources :questions, shallow: true
    member do
      get :take
      post :submit
    end
  end

  resources :quiz_attempts, only: [:show]

  get "profile", to: "users#profile", as: :profile

  resources :users, only: [:show], constraints: { id: /\d+/ }
end