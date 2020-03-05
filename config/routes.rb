Rails.application.routes.draw do
  resources :products, except: %w[new edit]
end
