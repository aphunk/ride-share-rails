Rails.application.routes.draw do
  resources :passengers do
    resources :trips, only: [:index, :new, :create, :edit, :update]
  end

  resources :drivers do
    resources :trips, only: [:index, :new]
  end
  
  resources :trips, only: [:edit, :update, :destroy]
  patch "/passengers/:passenger_id/trips/:id", to: "trips#update"
end
