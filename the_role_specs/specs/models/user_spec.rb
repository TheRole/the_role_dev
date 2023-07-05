# encoding: UTF-8

require 'rails_helper'

describe User do
  describe "Owner check for User and object" do
    context "Regular user" do
      let(:user_1) { create(:user) }
      let(:user_2) { create(:user) }

      let(:user_1_page) { create(:page, user: user_1) }
      let(:user_2_page) { create(:page, user: user_2) }

      it 'should have test varaibles' do
        expect(user_1).to be_instance_of User
        expect(user_2).to be_instance_of User

        expect(user_1_page).to be_instance_of Page
        expect(user_2_page).to be_instance_of Page
      end

      it 'should be owner of page' do
        expect(user_1.owner?(user_1_page)).to be_truthy
        expect(user_2.owner?(user_2_page)).to be_truthy
      end

      it 'should not be owner of page' do
        expect(user_1.owner?(user_2_page)).to be_falsey
        expect(user_2.owner?(user_1_page)).to be_falsey
      end
    end

    context "Moderator" do
      before(:each) do
        mrole = FactoryBot.create(:role_moderator)

        @moderator = FactoryBot.create(:user, role: mrole)
        @user      = FactoryBot.create(:user)

        @moderator_page = FactoryBot.create(:page, user: @moderator)
        @user_page      = FactoryBot.create(:page, user: @user)
      end

      it 'Moderator is owner of any Page' do
        expect(@moderator.owner?(@moderator_page)).to be_truthy
        expect(@moderator.owner?(@user_page)).to      be_truthy
      end

      it 'User is owner of his Pages' do
        expect(@user.owner?(@user_page)).to      be_truthy
        expect(@user.owner?(@moderator_page)).to be_falsey
      end
    end

    context "Admin" do
      # not important. to implement later
    end

    context "Custom Page relation to User" do
      before(:each) do
        Page.class_eval do
          belongs_to :user, class_name: 'User', foreign_key: 'person_id'
        end

        @user = create(:user)
        @page = create(:page, user: @user)
      end

      it 'relation via person_id' do
        @page.user_id.should   eq @user.id
        @page.person_id.should eq @user.id
      end
    end
  end

  describe "Create user without any Role" do
    before(:each) do
      FactoryBot.create(:user)
      @user = User.first
    end

    it "Create test user" do
      expect(User.count).to be 1
    end

    it "User have not any role" do
      expect(@user.role).to be_nil
    end

    it "User should gives false on any request" do
      expect(@user.has_role?(:pages, :index)).to     be_falsey
      expect(@user.has_role?(:moderator, :pages)).to be_falsey
    end
  end

  describe "Create user with default Role" do
    before(:each) do
      TheRole.config.default_user_role = :user
      FactoryBot.create(:role_user)
      FactoryBot.create(:user)
      @user = User.first
    end

    it "User and Role should exists" do
      expect(Role.count).to be 1
      expect(User.count).to be 1
    end

    it "Role should nave name :user" do
      expect(Role.first.name).to eq 'user'
    end

    it "User should have default Role" do
      expect(@user.role).not_to be_nil
    end

    it "User has Role for Pages" do
      expect(@user.has_role?(:pages, :index)).to   be_truthy
      expect(@user.has_role?(:pages, :destroy)).to be_truthy
    end

    it "User has disabled rule" do
      expect(@user.has_role?(:pages, :secret)).to be_falsey
    end

    it "User try to have access to undefined rule" do
      expect(@user.has_role?(:pages, :wrong_name)).to be_falsey
    end

    it "User has not Role for Atricles" do
      expect(@user.has_role?(:articles, :index)).to be_falsey
    end

    # Any
    it "should has any rules 1" do
      expect(@user.has_role?(:pages, :index)).to  be_truthy
      expect(@user.has_role?(:pages, :update)).to be_truthy

      expect(@user.any_role?({ pages: :index  })).to be_truthy
      expect(@user.any_role?({ pages: :update })).to be_truthy
      expect(@user.any_role?({ pages: [:index, :update]})).to be_truthy
    end

    it "should has any rules 2" do
      expect(@user.has_role?(:pages,    :index)).to be_truthy
      expect(@user.has_role?(:articles, :index)).to be_falsey

      expect(@user.any_role?({ pages:    :index })).to be_truthy
      expect(@user.any_role?({ articles: :index })).to be_falsey

      expect(@user.any_role?({ articles: :index })).to be_falsey
      expect(@user.any_role?({ pages: :index, articles: :index})).to be_truthy
      expect(@user.any_role?({ pages: [:index, :update]})).to be_truthy
    end

    it "should has any rules 3, easy syntaxis" do
      expect(@user.any_role?(articles: :index)).to be_falsey
      expect(@user.any_role?(pages: :index, articles: :index)).to be_truthy
      expect(@user.any_role?(pages: [:index, :update])).to be_truthy
    end
  end
end
