class PagesController < ApplicationController
  before_action :login_required, except: [:index, :show]
  before_action :role_required,  except: [:index, :show]

  # !!! ATTENTION !!!
  #
  # TheRole: You have to set object for ownership check
  # before check ownership via `owner_required` method
  # You can do it with `for_ownership_check(@page)` in `set_page`
  #
  before_action :set_page,       only: [:edit, :update, :destroy]
  before_action :owner_required, only: [:edit, :update, :destroy]

  # Public

  def index
    @pages = Page.with_state(:published).all
  end

  def show
    @page = Page.with_state(:published).find params[:id]
  end

  # Login && role

  def new
    @page = Page.new
  end

  def create
    @page = Page.new page_params

    if @page.save
      redirect_to @page, notice: 'Page was successfully created.'
    else
      render action: 'new'
    end
  end

  def my
    @pages = current_user.pages
  end

  # login && role && ownership

  def edit; end

  def update
    update_method = Rails::VERSION::MAJOR < 4 ? :update_attributes : :update

    if @page.send(update_method, page_params)
      redirect_to @page, notice: 'Page was successfully updated.'
    else
      render action: :edit
    end
  end

  def destroy
    @page.destroy
    redirect_to pages_url
  end

  # Admin or Pages Moderator Role require

  def manage
    @pages = Page.all
  end

  private

  def set_page
    @page = Page.find params[:id]

    # TheRole: object for ownership checking
    for_ownership_check(@page)
  end

  def page_params
    parameters.permit(:user_id, :title, :content, :state)
  end

  def parameters
    return params.require(:params).require(:page) if params.key?('params')
    params.require(:page)
  end
end
