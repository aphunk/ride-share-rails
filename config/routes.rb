Rails.application.routes.draw do
  resources :passengers do
    resources :trips, except: [:index, :new]
  end

  resources :drivers do
    resources :trips, except: [:index, :new]
  end
end
