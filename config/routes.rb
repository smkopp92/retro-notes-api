Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :retros, only: [:index, :create, :destroy] do
        resources :notes, only: [:index, :create]
        resource :slack, only: [:show]
      end
      resources :notes, only: [:destroy, :update]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
