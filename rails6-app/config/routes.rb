Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # TheRoleManagementPanel::Routes.mixin(self)

  root to: 'welcome#index'
  resources  :users, only: [:edit, :update]

  resources  :pages do
    collection do
      get :my
      get :manage
    end
  end
end
