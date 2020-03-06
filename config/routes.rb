Rails.application.routes.draw do
  resources :products, except: %w[new edit]
  resources :stores, except: %w[new edit]
  resources :orders, except: %w[new edit]
end
