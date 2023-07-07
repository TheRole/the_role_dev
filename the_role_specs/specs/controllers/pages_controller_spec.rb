require 'rails_helper'

describe PagesController, type: :controller do
  def view_var(name)
    controller.instance_variable_get("@#{name}")
  end

  def valid_page_attrs
    {
      title:   Faker::Lorem.sentence,
      content: Faker::Lorem.sentence,
      state:   :published
    }
  end

  def valid_page_for user
    valid_page_attrs.merge(user_id: user.id)
  end

  before(:each) do
    @role = create(:role_user)
    @moderator_role = create(:role_moderator)

    @owner = create(:user, role: @role)
    @hacker = create(:user, role: @role)
    @moderator = create(:user, role: @moderator_role)

    @owner.pages.create! valid_page_for(@owner)
  end

  describe "Guest" do
    describe 'NOT AUTORIZED/NO ROLE/NOT OWNER' do
      it "CREATE / but should be redirected" do
        post :create, params: { page: { fake: true } }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "User" do
    describe 'AUTORIZED/HAS ROLE/OWNER' do
      before(:each) { sign_in @owner }

      context "CREATE" do
        it "valid" do
          expect {
            post :create , params: { page: valid_page_for(@owner) }
          }.to change(Page, :count).by(1)
        end

        it "invalid params" do
          expect {
            post :create, params: { page: { fake: true } }
          }.to_not change(Page, :count)

          expect(response).to render_template :new
        end

        it "valid, no errors" do
          post :create , params: { page: valid_page_for(@owner) }
          expect(view_var(:page).errors).to be_empty
        end

        it "valid, redirect to SHOW" do
          post :create, params: { page: valid_page_for(@owner) }
          expect(response).to redirect_to page_path view_var(:page)
        end
      end

      context "UPDATE" do
        before(:each) do
          sign_in @owner
          @page = @owner.pages.last
        end

        it "users should has rules" do
          expect(@owner.has_role?(:pages, :update)).to  be_truthy
          expect(@hacker.has_role?(:pages, :update)).to be_truthy
        end

        it "page should be updated" do
          old_title = @page.title
          new_title = "test_title"

          expect {
            put :update, params: { id: @page, page: { title: new_title } }
            @page.reload
          }.to change(@page, :title).from(old_title).to(new_title)
        end
      end
    end

    describe 'AUTORIZED/HAS ROLE/NOT OWNER' do
      before(:each) { @page = @owner.pages.last }

      it "hacker should be blocked" do
        sign_in @hacker
        @request.env['HTTP_REFERER'] = '/'
        put :update, params: { id: @page, page: { title: "test_title" } }
        expect(response.body).to match access_denied_match
      end
    end
  end

  describe "Moderator" do
    before(:each) do
      @page = @owner.pages.last

      @old_title = @page.title
      @new_title = Faker::Lorem.sentence
    end

    it "Owner can update page" do
      sign_in @owner

      expect {
        put :update, params: { id: @page, page: { title: @new_title } }
        @page.reload
      }.to change(@page, :title).from(@old_title).to(@new_title)
    end

    it "Moderator can update page" do
      sign_in @moderator

      expect {
        put :update, params: { id: @page, page: { title: @new_title } }
        @page.reload
      }.to change(@page, :title).from(@old_title).to(@new_title)
    end

    it "Hacker cant update page" do
      sign_in @hacker
      @request.env['HTTP_REFERER'] = '/'

      expect {
        put :update, params: { id: @page, page: { title: @new_title } }
        @page.reload
      }.not_to change(@page, :title)
    end
  end
end

# assigns(:page).should eq @page
# response.should render_template :manage
# response.should redirect_to new_user_session_path
