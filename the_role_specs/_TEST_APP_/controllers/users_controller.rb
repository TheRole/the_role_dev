class UsersController < ApplicationController
  before_action :login_required
  before_action :role_required

  before_action :find_user,      :only => [:edit, :update]
  before_action :owner_required, :only => [:edit, :update]

  def edit; end

  def update
    @user.update_attributes params[:user]
    flash[:notice] = 'User was successfully updated.'
    redirect_to edit_user_path @user
  end

  def change_role
    @user = User.find params[:user_id]
    @role = Role.find params[:role_id]
    @user.update_attribute(:role, @role)
    redirect_to edit_user_path @user
  end

  private

  def find_user
    @user = User.find params[:id]

    # TheRole: You have to define object for ownership check
    for_ownership_check(@user)
  end
end
