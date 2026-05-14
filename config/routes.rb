# frozen_string_literal: true

Rails.application.routes.draw do
  root 'root#show'
  match '/', to: 'application#method_not_allowed', via: :all

  namespace :api do
    namespace :v1 do
      get 'health', to: 'health#show'
      get 'ready', to: 'health#ready'
      resources :items, only: %i[index show create]
    end
  end

  match '/api/v1/health', to: 'application#method_not_allowed', via: :all
  match '/api/v1/ready', to: 'application#method_not_allowed', via: :all
  match '/api/v1/items', to: 'application#method_not_allowed', via: :all
  match '/api/v1/items/:id', to: 'application#method_not_allowed', via: :all

  match '*unmatched', to: 'application#not_found', via: :all
end
