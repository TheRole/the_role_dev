Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # draw("../../the_role_specs/_TEST_APP_/routes.rb")
  root to: 'welcome#index'
  resources  :users, only: [:edit, :update]

  resources  :pages do
    collection do
      get :my
      get :manage
    end
  end
end
