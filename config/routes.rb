Rails.application.routes.draw do

  root 'tests#index'

  get 'feedback', to: 'communication#feedback'
  post 'feedback_send', to: 'communication#feedback_send'

  devise_for :users, path: :gurus, path_names: { sign_up: :signup, sign_in: :login, sign_out: :logout }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tests, only: :index do
    member do
      post :start
    end
  end

  resources :history_tests, only: %i[show update] do
    member do
      get :result
      post :gist
    end
  end

  namespace :admin do
    resources :tests do
      patch :update_inline, on: :member
      
      resources :questions, shallow: true, except: :index do
        resources :answers, shallow: true, except: :index
      end
    end
    
    resources :gists, only: %i[index destroy]
  end

end
