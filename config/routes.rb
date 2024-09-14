Rails.application.routes.draw do
  root "weather#index"
  post "get_weather", to: "weather#get_weather"
  get "result", to: "weather#result"
  get "/get_weather", to: "weather#get_weather"

  # Alternatively, you can set up a more resourceful route
  resources :weather, only: [ :index, :create ]

end
