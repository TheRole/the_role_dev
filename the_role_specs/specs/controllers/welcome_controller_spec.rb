require 'rails_helper'

describe WelcomeController, type: :controller do
  describe "GET for GUESTS" do
    it "*INDEX* test *subject* object" do
      get :index
      expect(subject.class).to eq(WelcomeController)
    end

    it "*INDEX* returns http success" do
      get :index
      expect(response.successful?).to be_truthy
    end

    it "*INDEX* render :index page" do
      get :index
      expect(response).to render_template :index
    end

    it "*INDEX* *current_user* should be nil" do
      get :index
      expect(subject.current_user).to be_nil
    end

    it "*PROFILE* will be redirect" do
      get :profile
      expect(response).to be_redirect
    end

    it "*PROFILE* will be redirect to new_user_session_path page" do
      get :profile
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "GET for LOGGED_IN users" do
    before(:each) do
      @user = create(:user)
      sign_in @user
    end

    after(:each) do
      User.destroy_all
    end

    it "One user should be exists" do
      expect(User.count).to be 1
    end

    it "*PROFILE* should render :profile page" do
      get :profile
      expect(response).to render_template :profile
    end

    it "*PROFILE* should not to be redirect" do
      get :profile
      expect(response).not_to be_redirect
    end

    it "*PROFILE* *current_user* helper should return user" do
      get :profile
      expect(subject.current_user).to eq(@user)
    end
  end
end
