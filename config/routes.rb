Rails.application.routes.draw do

  namespace :api, path: '/', defaults: { format: 'json' } do
    resources :cars, only: :index
    resources :car_configs, only: :create do
      resource :order, only: :create
    end
  end
end
