FactoryBot.define do
  factory :role_without_rules, class: Role do
    name        { 'User' }
    title       { 'Title of Role' }
    description { 'Description of role' }

  # classique functional of user
  role_user = {
    pages: {
      index:   true,
      show:    true,
      new:     true,
      create:  true,
      edit:    true,
      update:  true,
      destroy: true,
      my:      true,
      secret:  false
    }
  }

  FactoryBot.define do
    factory :role_user, class: Role do
      the_role     { role_user }
    end
  end

  # moderators have access only for pages
  role_moderator = {
    moderator: {
      pages: true
    }
  }

  FactoryBot.define do
    factory :role_moderator, class: Role do
      the_role    { role_moderator }
    end
  end
end
