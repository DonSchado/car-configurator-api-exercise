Rails.application.routes.draw do
  namespace :api, path: '/', defaults: { format: 'json' } do
    resources :cars
  end
end
