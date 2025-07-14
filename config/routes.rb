Rails.application.routes.draw do
  get 'pages/index'
  resources :clients
  resources :notebooks
  resources :handovers do
    member do
      get :complete_handover_form
      patch :complete_handover
    end
  end

  # Health check
  get 'up' => 'rails/health#show', as: :rails_health_check

  # PWA files
  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest

  # Root path
  root 'pages#index'
end
