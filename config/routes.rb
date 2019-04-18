Rails.application.routes.draw do
  resources :passengers do
<<<<<<< HEAD
    resources :trips, only: [:index, :new]
  end
  resources :drivers do
    resources :trips, only: [:index, :new]
=======
    resources :trips, except: [:index, :new]
  end

  resources :drivers do
    resources :trips, except: [:index, :new]
>>>>>>> 9c91bbcc68dee5f8dd51b82c6752523d514ee533
  end
end
