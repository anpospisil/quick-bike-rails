Rails.application.routes.draw do
  post "register", to: "auth#register"
  post "login", to: "auth#login"

  resources :bikes, only: [:index, :show, :create, :update]
  post "reservations", to: "reservations#create"
  patch "reservations/end", to: "reservations#end_reservation"
  get "reservations", to: "reservations#show_current"
end