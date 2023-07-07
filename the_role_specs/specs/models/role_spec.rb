require 'rails_helper'

describe Role do
  context "Role *Create* methods" do
    it "New/Create invalid" do
      role = Role.new
      expect(role.save).to be_falsey
      expect(role.errors.count).to eql(3)

      expect( role.errors[:name].present?        ).to eql true
      expect( role.errors[:title].present?       ).to eql true
      expect( role.errors[:description].present? ).to eql true
    end

    it "New/Create valid, without Role hash" do
      role = Role.new

      role.name        = :user
      role.title       = :user_title
      role.description = :role_description

      expect(role.save).to be_truthy
    end

    it "New/Create valid, without Role hash (2)" do
      expect(Role.create(
        name: :user,
        title: :user_title,
        description: :role_description
      )).to be_truthy
    end

    it "New/Create, without Role hash, default Role hash value" do
      role = create :role_without_rules
      expect(role.to_json).to eq("{}")
      expect(role.to_hash).to eq({})
    end

    it "New/Create, role methods result types" do
      role = create :role_without_rules
      expect(role.to_json).to be_an_instance_of String
      expect(role.to_hash).to be_an_instance_of Hash
    end

    it "New/Create, role have to be stored in DB as JSON String" do
      r = Role.create!(
        name:  :test_name,
        title: :test_title,
        description: :test_description,
        the_role: { any_section: { any_rule: true } }
      )

      expect( [Hash, String].include?(r.the_role.class) ).to be_truthy
      expect(r.to_json).to eq "{\"any_section\":{\"any_rule\":true}}"

      r = Role.create!(
        name:  :test_name1,
        title: :test_title1,
        description: :test_description1,
        the_role: "{\"any_section\":{\"any_rule\":false}}"
      )

      expect( [Hash, String].include?(r.the_role.class) ).to be_truthy
      expect(r.to_json).to eq "{\"any_section\":{\"any_rule\":false}}"
    end
  end

  context "Role *Section/Rule create* methods" do
    before(:each) do
      @role = create :role_without_rules
    end

    it "should have empty Role hash" do
      expect(@role.to_hash).to eq({})
    end

    it "Create section" do
      @role.create_section(:articles)
      expect(@role.to_hash).to eq({ "articles" => {} })
    end

    it "Create rule (with section)" do
      @role.create_section(:articles)
      @role.create_rule(:articles, :index)
      expect(@role.to_hash).to eq({ "articles" => { "index" => false } })
    end

    it "Create rule (without section)" do
      @role.create_rule(:articles, :index)
      expect(@role.to_hash).to eq({ "articles" => { "index" => false } })
    end
  end

  context "*has?* is aliace of *has_role?*" do
    before(:each) do
      @role = create :role_user
    end

    it "aliace methods" do
      expect(@role.has?(:pages, :index)).to      be_truthy
      expect(@role.has_role?(:pages, :index)).to be_truthy

      expect(@role.has?(:pages, :secret)).to      be_falsey
      expect(@role.has_role?(:pages, :secret)).to be_falsey
    end
  end

  context "Rule *On/Off* methods" do
    before(:each) do
      @role = create :role_user
    end

    it "has access to pages/index" do
      expect(@role.has_role?(:pages, :index)).to be_truthy
    end

    it "set pages/index on false" do
      @role.rule_off(:pages, :index)
      expect(@role.has_role?(:pages, :index)).to be_falsey
    end

    it "has no access to pages/secret" do
      expect(@role.has_role?(:pages, :secret)).to be_falsey
    end

    it "set pages/secret on true" do
      @role.rule_on(:pages, :secret)
      expect(@role.has_role?(:pages, :secret)).to be_truthy
    end
  end

  context "Class Methods" do
    before(:each) do
      @role = create :role_user
    end

    it "Role.with_name(:name) method" do
      expect(Role.with_name(:user)).to  be_an_instance_of Role
      expect(Role.with_name('user')).to be_an_instance_of Role

      expect(Role.with_name(:moderator)).to  be_nil
      expect(Role.with_name('moderator')).to be_nil
    end
  end

  context "*Delete* methods" do
    before(:each) do
      @role = create :role_user
    end

    it "*has_section?* method" do
      expect(@role.has_section?(:pages)).to    be_truthy
      expect(@role.has_section?(:articles)).to be_falsey
    end

    it "has pages section" do
      expect(@role.to_hash['pages']).to be_an_instance_of Hash
    end

    it "has pages/index value" do
      expect(@role.to_hash['pages']['index']).to be_truthy
    end

    it "delete rule pages/index" do
      @role.delete_rule(:pages, :index)
      expect(@role.to_hash['pages']['index']).to be_nil
    end

    it "delete section pages" do
      @role.delete_section(:pages)
      expect(@role.to_hash['pages']).to be_nil
    end
  end

  context "*helper* methods" do
    before(:each) do
      @role = create :role_without_rules
    end

    it "to_hash on empty rules set" do
      expect(@role.to_hash).to eq({})
    end

    it "to_json on empty rules set" do
      expect(@role.to_json).to eq("{}")
    end
  end

  context "Update method" do
    before(:each) do
      @role = create :role_user
    end

    it "should has true rules" do
      expect(@role.has?(:pages, :index)).to  be_truthy
      expect(@role.has?(:pages, :edit)).to   be_truthy
      expect(@role.has?(:pages, :update)).to be_truthy
      expect(@role.has?(:pages, :secret)).to be_falsey

      expect(@role.has?(:articles, :index)).to be_falsey
    end

    it "should has true rules" do
      @role.update_role({ articles: { index: true } })

      expect(@role.has?(:pages, :index)).to  be_falsey
      expect(@role.has?(:pages, :edit)).to   be_falsey
      expect(@role.has?(:pages, :update)).to be_falsey
      expect(@role.has?(:pages, :secret)).to be_falsey

      expect(@role.has?(:articles, :index)).to be_truthy
    end

    it "should has any rules 1" do
      expect(@role.has?(:pages, :index)).to  be_truthy
      expect(@role.has?(:pages, :update)).to be_truthy

      expect(@role.any?({ pages: [:index]  })).to be_truthy
      expect(@role.any?({ pages: [:update] })).to be_truthy
      expect(@role.any?({ pages: [:index, :update]})).to be_truthy
      expect(@role.any?(undefined_section: [:index], pages:[:index])).to be_truthy
    end

    it "should has any rules 2" do
      expect(@role.has?(:pages,    :index)).to  be_truthy
      expect(@role.has?(:pages,    :secret)).to be_falsey
      expect(@role.has?(:articles, :index)).to  be_falsey

      expect(@role.any?({ pages:    [:index] })).to be_truthy
      expect(@role.any?({ articles: [:index] })).to be_falsey

      expect(@role.any?({ articles: [:index] })).to be_falsey
      expect(@role.any?({ pages: [:index], articles: [:index]})).to be_truthy
      expect(@role.any?({ pages: [:index, :update]})).to be_truthy

      expect(@role.any?(pages: :secret)).to          be_falsey
      expect(@role.any?(pages: [:secret])).to        be_falsey
      expect(@role.any?(pages: [:edit, :secret])).to be_truthy
      expect(@role.any?(pages: :secret, articles: :index)).to be_falsey
    end

    it "should has any rules 3, easy syntaxis" do
      expect(@role.any?(articles: [:index])).to be_falsey
      expect(@role.any?(pages: [:index], articles: [:index])).to be_truthy
      expect(@role.any?(pages: [:index, :update])).to be_truthy
    end

    it "should hasn't any rules" do
      expect(@role.any?(undefined_section:[:new])).to be_falsey
    end
  end
end
