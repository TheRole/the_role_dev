Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # TheRole routes are placed in an external folder
  # See config/application.rb
end
