# classique role for user
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

# moderator have access only for pages
role_moderator = {
  moderator: {
    pages: true
  }
}

FactoryBot.define do
  factory :role_without_rules, class: Role do
    name        { 'Role' }
    title       { 'Default title for Role' }
    description { 'Default example of role' }

    factory :role_user do
      the_role     { role_user }
    end

    factory :role_moderator do
      the_role    { role_moderator }
    end
  end
end
