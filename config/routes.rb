Rails.application.routes.draw do
  root "homepages#index"
  resources :homepages, only: :index

  resources :passengers do
    resources :trips
  end

  resources :drivers do
    resources :trips, only: [:index, :new]
  end

  resources :trips
  patch "/passengers/:passenger_id/trips/:id", to: "trips#update"
end
