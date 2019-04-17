Rails.application.routes.draw do
  root to: 'oogiri_events#index'
  resources :oogiri_events

end
