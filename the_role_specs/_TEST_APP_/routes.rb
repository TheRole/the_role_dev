Rails.application.routes.draw do
  root to: 'welcome#index'
  resources  :users, only: [:edit, :update]

  # TheRoleManagementPanel::Routes.mixin(self)

  resources  :pages do
    collection do
      get :my
      get :manage
    end
  end
end
