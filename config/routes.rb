Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :retros, only: [:index, :create, :destroy] do
        resources :notes, only: [:index, :create]
        resource :slack, only: [:show]
      end
      resource :user, only: [:show]
      resources :notes, only: [:destroy, :update]
    end
  end

  get "/auth/:provider/callback", to: "api/v1/users#create"
  get "/auth/failure", to: "api/v1/users#failure"
  get "/sign_in", to: "api/v1/users#sign_in"
  get "/sign_out", to: "api/v1/users#destroy"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
