require "spec_helper"

describe Admin::RolesController do
  describe "routing" do
    describe "collection block" do

      describe "get" do
        it "admin_roles_path routes to #index" do
          expect(get(admin_roles_path)).to route_to("admin/roles#index")
        end

        it "new_admin_role_path routes to #new" do
          expect(get(new_admin_role_path)).to route_to("admin/roles#new")
        end
      end
    end

    describe "member block" do
      before(:all) do
        @role = FactoryBot.create(:role_user)
      end

      after(:all) do
        Role.destroy_all
      end

      describe "post" do
        it "CREATE SECTION PATH" do
          be_routed = route_to(:controller => "admin/role_sections", :action => 'create', :role_id => @role.to_param)
          expect(post(admin_role_sections_path(@role))).to be_routed
        end

        it "CREATE RULE PATH" do
          be_routed = route_to(:controller => "admin/role_sections", :action => 'create_rule', :role_id => @role.to_param)
          expect(post(create_rule_admin_role_sections_path(@role))).to be_routed
        end
      end
    end

  end
end
