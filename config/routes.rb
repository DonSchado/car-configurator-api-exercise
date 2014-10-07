Rails.application.routes.draw do

  namespace :api, path: '/', defaults: { format: 'json' } do
    resources :cars, only: :index
    resources :car_configs, only: :create do
      # member do
      #   :order
      # end
    end
  end
end
