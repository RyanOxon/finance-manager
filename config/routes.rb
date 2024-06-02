Rails.application.routes.draw do
  root "home#index"

  resources :billings, only: [:new, :create, :edit, :update, :show] do
    get :dashboard , on: :collection
  end

end