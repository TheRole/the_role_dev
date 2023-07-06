Rails.application.routes.draw do
  root to: 'welcome#index'
  get 'welcome/index'
  get 'welcome/profile'

  resources  :users, only: [:edit, :update]

  resources  :pages do
    collection do
      get :my
      get :manage
    end
  end
end
