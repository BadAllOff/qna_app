FactoryGirl.define do
  factory :role do
    role_sid "rolesid"
    role_title "Role title"
    role_description "Role description"
  end

  factory :invalid_role, class: "Role" do
    role_sid nil
    role_title nil
    role_description nil
  end

end
