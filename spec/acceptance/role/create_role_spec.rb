require 'acceptance/acceptance_helper'

feature "Create Role", %q{
        In order to create and set roles
        As an Admin
        I want be able to create roles
  } do

  given(:admin) { create(:user, role_sid: 'admin') }
  given(:user)  { create(:user, role_sid: 'user') }

  scenario 'Admin creates role' do

    sign_in(admin)

    visit roles_path
    click_on 'New Role'
    fill_in 'Role sid', with: 'testrole'
    fill_in 'Role title', with: 'Role title'
    fill_in 'Role description', with: 'Role description'
    click_on 'Create Role'

    expect(page).to have_content 'Role was successfully created.'
  end

  scenario 'Authenticated User cannot create role' do
    sign_in(user)

    visit roles_path
    click_on 'New Role'
    expect(page).to have_content 'Action prohibited!'
  end

  scenario 'Non-authenticated user cannot create role' do
    visit roles_path
    expect(page).to have_content 'Action prohibited!'
  end


end