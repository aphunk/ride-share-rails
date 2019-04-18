Rails.application.routes.draw do
  resources :passengers do
    resources :trips, only: [:index, :new]
  end
  resources :drivers do
    resources :trips, only: [:index, :new]
  end
end
